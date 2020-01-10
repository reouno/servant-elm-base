module Usecase.Interface.Post.PostStore where

import           Conduit       ( MonadUnliftIO )

import           Entity.Entity ( Post (..), PostId, PostRecord )

class PostStore pool where
  getPosts :: MonadUnliftIO m => pool -> m [PostRecord]
  newPost :: MonadUnliftIO m => pool -> Post -> m PostId
  getPost :: MonadUnliftIO m => pool -> PostId -> m (Maybe Post)
  replacePost :: MonadUnliftIO m => pool -> PostId -> Post -> m ()
  deletePost :: MonadUnliftIO m => pool -> PostId -> m ()
