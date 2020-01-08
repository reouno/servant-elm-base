module Usecase.Interactor.PlainDiaryServer where

import           Conduit                                           ( MonadUnliftIO )

import           Entity.Entity                                     ( Post, PostId, PostRecord )
import qualified Usecase.Interface.Diary.DiaryStore                as UC
import           Usecase.Interface.PersistentStore.PersistentStore ( PersistentStore )

getDiaries :: (MonadUnliftIO m, PersistentStore pool) => pool -> m [PostRecord]
getDiaries = UC.getDiaries

newDiary :: (MonadUnliftIO m, PersistentStore pool) => pool -> Post -> m PostId
newDiary = UC.newDiary

getDiary ::
     (MonadUnliftIO m, PersistentStore pool) => pool -> PostId -> m (Maybe Post)
getDiary = UC.getDiary

replaceDiary ::
     (MonadUnliftIO m, PersistentStore pool) => pool -> PostId -> Post -> m ()
replaceDiary = UC.replaceDiary

deleteDiary :: (MonadUnliftIO m, PersistentStore pool) => pool -> PostId -> m ()
deleteDiary = UC.deleteDiary
