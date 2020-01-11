module Usecase.Interface.PersistentStore.PersistentStore where

import           Usecase.Interface.Like.LikeStore ( LikeStore )
import           Usecase.Interface.Post.PostStore ( PostStore )
import           Usecase.Interface.User.UserStore ( UserStore )

class (LikeStore pool, PostStore pool, UserStore pool) =>
      PersistentStore pool
  where
  withPool :: (pool -> IO a) -> IO a
  doMigration :: pool -> IO ()
