{-# LANGUAGE DataKinds        #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE TypeOperators    #-}

module InterfaceAdapter.PersistentStore.Model.Post.Adapter where

import           Control.Lens
import           Data.Extensible
import           Data.Text                                           hiding ( map )
import           Database.Persist.Sql
import           Database.Persist.Types                              ( Entity )

import           Entity.Entity                                       ( Post (..), PostId,
                                                                       PostRecord )
import qualified InterfaceAdapter.PersistentStore.Model              as M
import           InterfaceAdapter.PersistentStore.Model.User.Adapter ( fromEntityUserId,
                                                                       toEntityUserId )
import           PersistentUtil                                      ( entity2Tuple, int2SqlKey,
                                                                       sqlKey2Int )

-- NOTE: Cannot create M.PostImage data because the PostId is unknown.
fromEntityPost :: Post -> (M.Post, [Text])
fromEntityPost post = (post', images)
  where
    post' =
      M.Post
        (fromEntityUserId $ post ^. #userId)
        (post ^. #title)
        (post ^. #content)
        (post ^. #allowAutoEdit)
        (post ^. #createdAt)
        (post ^. #updatedAt)
    images = post ^. #imageUrls

fromEntityPostId :: PostId -> M.PostId
fromEntityPostId = int2SqlKey

-- NOTE: Can take [M.PostImage] as an argument instead of [Text]
--       but use the similar I/F with `fromEntityPost`
toEntityPost :: M.Post -> [Text] -> Post
toEntityPost (M.Post userId title content allowAutoEdit createdAt updatedAt) images =
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

toEntityPost' :: M.Post -> [M.PostImage] -> Post
toEntityPost' post images = toEntityPost post $ map M.postImageUrl images

toEntityPostId :: M.PostId -> PostId
toEntityPostId = sqlKey2Int
