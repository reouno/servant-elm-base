module Usecase.Interactor.PlainUserServer where

import           Conduit                        ( MonadUnliftIO )
import           Control.Monad.IO.Class         ( liftIO )
import           Data.Time                      ( getCurrentTime )

import           Entity.Entity                  ( User(..)
                                                , UserId
                                                , UserRecord
                                                , UserUniqueKey
                                                )
import           Usecase.Interface.PersistentStore.PersistentStore
                                                ( PersistentStore(..) )
import qualified Usecase.Interface.User.UserStore
                                               as UC

getUsers :: (MonadUnliftIO m, PersistentStore pool) => pool -> m [UserRecord]
getUsers = UC.getUsers

newUser :: (MonadUnliftIO m, PersistentStore pool) => pool -> User -> m UserId
newUser pool user = do
  now <- liftIO getCurrentTime
  UC.newUser pool now user

getUser
  :: (MonadUnliftIO m, PersistentStore pool) => pool -> UserId -> m (Maybe User)
getUser = UC.getUser

getUserBy
  :: (MonadUnliftIO m, PersistentStore pool)
  => pool
  -> UserUniqueKey
  -> m (Maybe UserRecord)
getUserBy = UC.getUserBy

replaceUser
  :: (MonadUnliftIO m, PersistentStore pool) => pool -> UserId -> User -> m ()
replaceUser pool userId user = do
  now <- liftIO getCurrentTime
  UC.replaceUser pool now userId user

deleteUser :: (MonadUnliftIO m, PersistentStore pool) => pool -> UserId -> m ()
deleteUser = UC.deleteUser
