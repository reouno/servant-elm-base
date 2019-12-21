{-# LANGUAGE DataKinds        #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE TypeOperators    #-}

module InterfaceAdapter.PersistentStore.Model.Diary.Adapter where

import           Control.Lens
import           Data.Extensible
import           Data.Text
import           Database.Persist.Sql                                ( entityKey, entityVal )
import           Database.Persist.Types                              ( Entity )

import           Entity.Entity                                       ( Diary (..), DiaryId,
                                                                       DiaryRecord )
import qualified InterfaceAdapter.PersistentStore.Model              as M
import           InterfaceAdapter.PersistentStore.Model.User.Adapter ( fromEntityUserId )
import           PersistentUtil                                      ( entity2Tuple, int2SqlKey,
                                                                       sqlKey2Int )

-- NOTE: Cannot create M.DiaryImage data because the DiaryId is unknown.
fromEntityDiary :: Diary -> (M.Diary, [Text])
fromEntityDiary diary = (diary', images)
  where
    diary' =
      M.Diary
        (fromEntityUserId $ diary ^. #userId)
        (diary ^. #title)
        (diary ^. #content)
        (diary ^. #allowAutoEdit)
        (diary ^. #createdAt)
        (diary ^. #updatedAt)
    images = diary ^. #imageUrls
