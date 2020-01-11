module Usecase.Interactor.PlainLikeServer where

import           Conduit                                           ( MonadUnliftIO )

import           Entity.Entity                                     ( Like, LikeId, LikeRecord )
import qualified Usecase.Interface.Like.LikeStore                  as UC
import           Usecase.Interface.PersistentStore.PersistentStore ( PersistentStore )

getLikes :: (MonadUnliftIO m, PersistentStore pool) => pool -> m [LikeRecord]
getLikes = UC.getLikes

newLike :: (MonadUnliftIO m, PersistentStore pool) => pool -> Like -> m LikeId
newLike = UC.newLike

getLike ::
     (MonadUnliftIO m, PersistentStore pool) => pool -> LikeId -> m (Maybe Like)
getLike = UC.getLike

deleteLike :: (MonadUnliftIO m, PersistentStore pool) => pool -> LikeId -> m ()
deleteLike = UC.deleteLike
