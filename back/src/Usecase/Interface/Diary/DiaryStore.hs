module Usecase.Interface.Diary.DiaryStore where

import           Conduit       ( MonadUnliftIO )

import           Entity.Entity ( Post (..), PostId, PostRecord )

class DiaryStore pool where
  getDiaries :: MonadUnliftIO m => pool -> m [PostRecord]
  newDiary :: MonadUnliftIO m => pool -> Post -> m PostId
  getDiary :: MonadUnliftIO m => pool -> PostId -> m (Maybe Post)
  replaceDiary :: MonadUnliftIO m => pool -> PostId -> Post -> m ()
  deleteDiary :: MonadUnliftIO m => pool -> PostId -> m ()
