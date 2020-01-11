module Usecase.Interface.Like.LikeStore where

import           Conduit       ( MonadUnliftIO )

import           Entity.Entity ( Like (..), LikeId, LikeRecord )

class LikeStore pool where
  getLikes :: MonadUnliftIO m => pool -> m [LikeRecord]
  newLike :: MonadUnliftIO m => pool -> Like -> m LikeId
  getLike :: MonadUnliftIO m => pool -> LikeId -> m (Maybe Like)
  deleteLike :: MonadUnliftIO m => pool -> LikeId -> m ()
