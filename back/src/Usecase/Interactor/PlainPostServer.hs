module Usecase.Interactor.PlainPostServer where

import           Conduit                                           ( MonadUnliftIO )

import           Entity.Entity                                     ( Post, PostId, PostRecord )
import           Usecase.Interface.PersistentStore.PersistentStore ( PersistentStore )
import qualified Usecase.Interface.Post.PostStore                  as UC

getPosts :: (MonadUnliftIO m, PersistentStore pool) => pool -> m [PostRecord]
getPosts = UC.getPosts

newPost :: (MonadUnliftIO m, PersistentStore pool) => pool -> Post -> m PostId
newPost = UC.newPost

getPost ::
     (MonadUnliftIO m, PersistentStore pool) => pool -> PostId -> m (Maybe Post)
getPost = UC.getPost

replacePost ::
     (MonadUnliftIO m, PersistentStore pool) => pool -> PostId -> Post -> m ()
replacePost = UC.replacePost

deletePost :: (MonadUnliftIO m, PersistentStore pool) => pool -> PostId -> m ()
deletePost = UC.deletePost
