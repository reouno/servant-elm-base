module InterfaceAdapter.Controller.PlainUserServer where

import           Control.Monad.IO.Class                            ( liftIO )
import           Servant                                           ( (:<|>) (..), NoContent (..),
                                                                     Server )

import           InterfaceAdapter.Presenter.User.UserApi           ( UserApi )
import           Usecase.Interactor.PlainUserServer                ( deleteUser, getUser, getUsers,
                                                                     newUser, replaceUser )
import           Usecase.Interface.PersistentStore.PersistentStore ( PersistentStore )

plainUserServer :: PersistentStore pool => pool -> Server UserApi
plainUserServer pool = getEntities pool :<|> newEntity pool :<|> operations pool
  where
    getEntities = liftIO . getUsers
    newEntity pool user = liftIO $ newUser pool user >> return NoContent
    operations pool id' =
      getEntity pool id' :<|> updateEntity pool id' :<|> deleteEntity pool id'
    getEntity pool id' = liftIO $ getUser pool id'
    updateEntity pool id' user =
      liftIO $ replaceUser pool id' user >> return NoContent
    deleteEntity pool id' = liftIO $ deleteUser pool id' >> return NoContent
