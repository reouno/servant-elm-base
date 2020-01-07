{-# LANGUAGE DataKinds        #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE TypeOperators    #-}

module InterfaceAdapter.PersistentStore.Model.Diary.Adapter where

import           Control.Lens
import           Data.Extensible
import           Data.Text                                           hiding ( map )
import           Database.Persist.Sql
import           Database.Persist.Types                              ( Entity )

import           Entity.Entity                                       ( Diary (..), DiaryId,
                                                                       DiaryRecord )
import qualified InterfaceAdapter.PersistentStore.Model              as M
import           InterfaceAdapter.PersistentStore.Model.User.Adapter ( fromEntityUserId,
                                                                       toEntityUserId )
import           PersistentUtil                                      ( entity2Tuple, int2SqlKey,
                                                                       sqlKey2Int )

-- NOTE: Cannot create M.DiaryImage data because the PostId is unknown.
fromEntityDiary :: Diary -> (M.Post, [Text])
fromEntityDiary diary = (diary', images)
  where
    diary' =
      M.Post
        (fromEntityUserId $ diary ^. #userId)
        (diary ^. #title)
        (diary ^. #content)
        (diary ^. #allowAutoEdit)
        (diary ^. #createdAt)
        (diary ^. #updatedAt)
    images = diary ^. #imageUrls

fromEntityDiaryId :: DiaryId -> M.PostId
fromEntityDiaryId = int2SqlKey

-- NOTE: Can take [M.DiaryImage] as an argument instead of [Text]
--       but use the similar I/F with `fromEntityDiary`
toEntityDiary :: M.Post -> [Text] -> Diary
toEntityDiary (M.Post userId title content allowAutoEdit createdAt updatedAt) images =
  #title @= title <: #content @= content <: #imageUrls @= images <:
  #allowAutoEdit @=
  allowAutoEdit <:
  #createdAt @=
  createdAt <:
  #updatedAt @=
  updatedAt <:
  #userId @=
  toEntityUserId userId <:
  emptyRecord

toEntityDiary' :: M.Post -> [M.DiaryImage] -> Diary
toEntityDiary' diary images = toEntityDiary diary $ map M.diaryImageUrl images

toEntityDiaryId :: M.PostId -> DiaryId
toEntityDiaryId = sqlKey2Int
