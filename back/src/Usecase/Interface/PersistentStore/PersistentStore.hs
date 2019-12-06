module Usecase.Interface.PersistentStore.PersistentStore where

import           Usecase.Interface.User.UserStore ( UserStore )

class UserStore pool =>
      PersistentStore pool
  where
  mkPool :: IO pool
  doMigration :: pool -> IO ()
