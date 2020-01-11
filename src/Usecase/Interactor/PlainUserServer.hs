module Usecase.Interactor.PlainUserServer where

import           Conduit                                           ( MonadUnliftIO )

import           Entity.Entity                                     ( User (..), UserId, UserRecord,
                                                                     UserUniqueKey )
import           Usecase.Interface.PersistentStore.PersistentStore ( PersistentStore (..) )
import qualified Usecase.Interface.User.UserStore                  as UC

getUsers :: (MonadUnliftIO m, PersistentStore pool) => pool -> m [UserRecord]
getUsers = UC.getUsers

newUser :: (MonadUnliftIO m, PersistentStore pool) => pool -> User -> m UserId
newUser = UC.newUser

getUser ::
     (MonadUnliftIO m, PersistentStore pool) => pool -> UserId -> m (Maybe User)
getUser = UC.getUser

getUserBy ::
     (MonadUnliftIO m, PersistentStore pool)
  => pool
  -> UserUniqueKey
  -> m (Maybe UserRecord)
getUserBy = UC.getUserBy

replaceUser ::
     (MonadUnliftIO m, PersistentStore pool) => pool -> UserId -> User -> m ()
replaceUser = UC.replaceUser

deleteUser :: (MonadUnliftIO m, PersistentStore pool) => pool -> UserId -> m ()
deleteUser = UC.deleteUser
