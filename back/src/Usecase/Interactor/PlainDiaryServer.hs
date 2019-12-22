module Usecase.Interactor.PlainDiaryServer where

import           Conduit                                           ( MonadUnliftIO )

import           Entity.Entity                                     ( Diary, DiaryId, DiaryRecord )
import qualified Usecase.Interface.Diary.DiaryStore                as UC
import           Usecase.Interface.PersistentStore.PersistentStore ( PersistentStore )

getDiaries :: (MonadUnliftIO m, PersistentStore pool) => pool -> m [DiaryRecord]
getDiaries = UC.getDiaries

newDiary ::
     (MonadUnliftIO m, PersistentStore pool) => pool -> Diary -> m DiaryId
newDiary = UC.newDiary

getDiary ::
     (MonadUnliftIO m, PersistentStore pool)
  => pool
  -> DiaryId
  -> m (Maybe Diary)
getDiary = UC.getDiary

replaceDiary ::
     (MonadUnliftIO m, PersistentStore pool) => pool -> DiaryId -> Diary -> m ()
replaceDiary = UC.replaceDiary

deleteDiary ::
     (MonadUnliftIO m, PersistentStore pool) => pool -> DiaryId -> m ()
deleteDiary = UC.deleteDiary
