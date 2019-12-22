module Usecase.Interface.PersistentStore.PersistentStore where

import           Usecase.Interface.Diary.DiaryStore ( DiaryStore )
import           Usecase.Interface.User.UserStore   ( UserStore )

class (UserStore pool, DiaryStore pool) =>
      PersistentStore pool
  where
  withPool :: (pool -> IO a) -> IO a
  doMigration :: pool -> IO ()
