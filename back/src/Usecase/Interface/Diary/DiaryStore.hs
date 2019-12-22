module Usecase.Interface.Diary.DiaryStore where

import           Conduit       ( MonadUnliftIO )

import           Entity.Entity ( Diary (..), DiaryId, DiaryRecord )

class DiaryStore pool where
  getDiaries :: MonadUnliftIO m => pool -> m [DiaryRecord]
  newDiary :: MonadUnliftIO m => pool -> Diary -> m DiaryId
  getDiary :: MonadUnliftIO m => pool -> DiaryId -> m (Maybe Diary)
  replaceDiary :: MonadUnliftIO m => pool -> DiaryId -> Diary -> m ()
  deleteDiary :: MonadUnliftIO m => pool -> DiaryId -> m ()
