module InterfaceAdapter.Controller.PostApiHandler where

import           Control.Monad.IO.Class                            ( liftIO )
import           Servant                                           ( (:<|>) (..), NoContent (..),
                                                                     Server )
import           ServantUtil                                       ( EntityRecord (..) )

import           InterfaceAdapter.Presenter.Post.PostApi           ( PostApi )
import           Usecase.Interactor.PlainPostServer                ( deletePost, getPost, getPosts,
                                                                     newPost, replacePost )
import           Usecase.Interface.PersistentStore.PersistentStore ( PersistentStore )

postApiHandler :: PersistentStore pool => pool -> Server PostApi
postApiHandler pool = getEntities pool :<|> newEntity pool :<|> operations pool
  where
    getEntities = liftIO . (fmap (map (uncurry EntityRecord)) . getPosts)
    newEntity pool user = liftIO $ newPost pool user >> return NoContent
    operations pool id' =
      getEntity pool id' :<|> updateEntity pool id' :<|> deleteEntity pool id'
    getEntity pool id' = liftIO $ getPost pool id'
    updateEntity pool id' user =
      liftIO $ replacePost pool id' user >> return NoContent
    deleteEntity pool id' = liftIO $ deletePost pool id' >> return NoContent
