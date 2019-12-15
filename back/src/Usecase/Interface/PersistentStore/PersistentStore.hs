module Usecase.Interface.PersistentStore.PersistentStore where

import           Usecase.Interface.User.UserStore ( UserStore )

class UserStore pool =>
      PersistentStore pool
  where
  withPool :: (pool -> IO a) -> IO a
  doMigration :: pool -> IO ()
