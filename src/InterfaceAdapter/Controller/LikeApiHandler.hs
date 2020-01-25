module InterfaceAdapter.Controller.LikeApiHandler where

import           Control.Monad.IO.Class                            ( liftIO )
import           Servant                                           ( (:<|>) (..), NoContent (..),
                                                                     Server )
import           ServantUtil                                       ( EntityRecord (..) )

import           InterfaceAdapter.Presenter.Like.LikeApi           ( LikeApi )
import           Usecase.Interactor.PlainLikeServer                ( deleteLike, getLike, getLikes,
                                                                     newLike )
import           Usecase.Interface.PersistentStore.PersistentStore ( PersistentStore )

likeApiHandler :: PersistentStore pool => pool -> Server LikeApi
likeApiHandler pool = getEntities pool :<|> newEntity pool :<|> operations pool
  where
    getEntities = liftIO . (fmap (map (uncurry EntityRecord)) . getLikes)
    newEntity pool user = liftIO $ newLike pool user >> return NoContent
    operations pool id' = getEntity pool id' :<|> deleteEntity pool id'
    getEntity pool id' = liftIO $ getLike pool id'
    deleteEntity pool id' = liftIO $ deleteLike pool id' >> return NoContent
