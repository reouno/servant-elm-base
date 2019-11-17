module InterfaceAdapter.Presenter.User.UserApiHandler where

import           Control.Monad.IO.Class                  ( liftIO )
import           Servant

import           Entity.Entity                           ( User (..), user1, user1Id )
import           InterfaceAdapter.Presenter.User.UserApi ( UserApi )

userRecords = [(user1Id, user1)]

userApiHandler :: Server UserApi
userApiHandler = getEntities :<|> newEntity :<|> operations
  where
    getEntities = liftIO $ return userRecords
    newEntity = error "newEntity is not implemented yet"
    operations id' = getEntity id' :<|> updateEntity id' :<|> deleteEntity id'
    getEntity id' = liftIO $ return $ head [x | (i, x) <- userRecords, i == id']
    updateEntity id' = error "updateEntity is not implemented yet"
    deleteEntity id' = error "deleteEntity is not implemented yet"
