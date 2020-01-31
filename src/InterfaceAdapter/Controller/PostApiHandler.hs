module InterfaceAdapter.Controller.PostApiHandler where

import           Control.Monad.IO.Class                            ( liftIO )
import           Data.Time                                         ( UTCTime )
import           Servant                                           ( (:<|>) (..), NoContent (..),
                                                                     Server )
import           ServantUtil                                       ( EntityRecord (..) )

import           InterfaceAdapter.Presenter.Post.PostApi           ( PostApi )
import           Usecase.Interactor.PlainPostServer                ( deletePost, getPost, getPosts,
                                                                     newPost, replacePost )
import           Usecase.Interface.PersistentStore.PersistentStore ( PersistentStore )

postApiHandler :: PersistentStore pool => UTCTime -> pool -> Server PostApi
postApiHandler now pool =
  getEntities pool :<|> newEntity pool :<|> operations pool
  where
    getEntities = liftIO . (fmap (map (uncurry EntityRecord)) . getPosts)
    -- newEntity pool user = liftIO $ newPost pool user >> return NoContent
    newEntity pool user = error "todo"
    operations pool id' =
      getEntity pool id' :<|> updateEntity pool id' :<|> deleteEntity pool id'
    getEntity pool id' = liftIO $ getPost pool id'
    updateEntity pool id' user = error "todo"
      -- liftIO $ replacePost pool id' user >> return NoContent
    deleteEntity pool id' = liftIO $ deletePost pool id' >> return NoContent
