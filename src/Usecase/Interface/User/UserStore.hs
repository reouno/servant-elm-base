module Usecase.Interface.User.UserStore where

import           Conduit                        ( MonadUnliftIO )

import           Entity.Entity                  ( User(..)
                                                , UserId
                                                , UserRecord
                                                , UserUniqueKey
                                                )

class UserStore pool where
  getUsers :: MonadUnliftIO m => pool -> m [UserRecord]
  newUser :: MonadUnliftIO m => pool -> User -> m UserId
  getUser :: MonadUnliftIO m => pool -> UserId -> m (Maybe User)
  getUserBy :: MonadUnliftIO m => pool -> UserUniqueKey -> m (Maybe UserRecord)
  replaceUser :: MonadUnliftIO m => pool -> UserId -> User -> m ()
  deleteUser :: MonadUnliftIO m => pool -> UserId -> m ()
