module InterfaceAdapter.Controller.PlainUserServer where

import           Control.Monad.IO.Class                            ( liftIO )
import           Servant                                           ( (:<|>) (..), NoContent (..),
                                                                     Server )

import           InterfaceAdapter.Presenter.User.UserApi           ( UserApi, UserBaseApi,
                                                                     UserManipulationApi )
import           Usecase.Interactor.PlainUserServer                ( deleteUser, getUser, getUserBy,
                                                                     getUsers, newUser, replaceUser )
import           Usecase.Interface.PersistentStore.PersistentStore ( PersistentStore )

baseApiHandler :: PersistentStore pool => pool -> Server UserBaseApi
baseApiHandler pool = getEntities pool :<|> newEntity pool :<|> operations pool
  where
    getEntities = liftIO . getUsers
    newEntity pool user = liftIO $ newUser pool user >> return NoContent
    operations pool id' =
      getEntity pool id' :<|> updateEntity pool id' :<|> deleteEntity pool id'
    getEntity pool id' = liftIO $ getUser pool id'
    updateEntity pool id' user =
      liftIO $ replaceUser pool id' user >> return NoContent
    deleteEntity pool id' = liftIO $ deleteUser pool id' >> return NoContent

manipulationApiHandler ::
     PersistentStore pool => pool -> Server UserManipulationApi
manipulationApiHandler = getEntityByUniqueKey
  where
    getEntityByUniqueKey pool key = liftIO $ getUserBy pool key

plainUserServer :: PersistentStore pool => pool -> Server UserApi
plainUserServer pool = baseApiHandler pool :<|> manipulationApiHandler pool
