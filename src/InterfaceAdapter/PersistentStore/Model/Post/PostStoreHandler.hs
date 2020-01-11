{-# LANGUAGE FlexibleContexts    #-}
{-# LANGUAGE FlexibleInstances   #-}
{-# LANGUAGE GADTs               #-}
{-# LANGUAGE OverloadedLabels    #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators       #-}

module InterfaceAdapter.PersistentStore.Model.Post.PostStoreHandler where

import           Conduit                                               ( MonadUnliftIO )
import           Control.Monad.IO.Class                                ( liftIO )
import           Control.Monad.Reader                                  ( ReaderT )
import           Database.Persist
import           Database.Persist.Sql

import           Entity.Entity                                         ( PostRecord )
import           InterfaceAdapter.PersistentStore.Infra.Postgres.Types ( PgPool )
import qualified InterfaceAdapter.PersistentStore.Model                as M
import           InterfaceAdapter.PersistentStore.Model.Post.Adapter   ( fromEntityPost,
                                                                         fromEntityPostId,
                                                                         toEntityPost',
                                                                         toEntityPostId )
import           Usecase.Interface.Post.PostStore                      ( PostStore (..) )

instance PostStore PgPool where
  getPosts pool =
    flip runSqlPool pool $ do
      (posts :: [Entity M.Post]) <- selectList [] []
      mapM joinImages2Post posts
  newPost pool post = do
    let (post', images) = fromEntityPost post
    flip runSqlPool pool $ do
      postId <- insert post'
      mapM_ (insert_ . M.PostImage postId) images
      liftIO . return $ toEntityPostId postId
  getPost pool postId =
    flip runSqlPool pool $ do
      let postKey = fromEntityPostId postId
      mayPost <- get postKey
      case mayPost of
        Just post -> do
          images <- selectList [M.PostImagePostId ==. postKey] []
          liftIO . return . Just $ toEntityPost' post $ map entityVal images
        Nothing -> liftIO $ return Nothing
  replacePost pool postId post =
    flip runSqlPool pool $ do
      let (post', images) = fromEntityPost post
          postKey = fromEntityPostId postId
      replace postKey post'
      deleteWhere [M.PostImagePostId ==. postKey]
      mapM_ (insert_ . M.PostImage postKey) images
  deletePost pool postId =
    flip runSqlPool pool $ do
      let postKey = fromEntityPostId postId
      delete postKey
      deleteWhere [M.PostImagePostId ==. postKey]

joinImages2Post ::
     MonadUnliftIO m => Entity M.Post -> ReaderT SqlBackend m PostRecord
joinImages2Post post = do
  let postKey = entityKey post
  images <- selectList [M.PostImagePostId ==. postKey] []
  let post' = toEntityPost' (entityVal post) $ map entityVal images
  return (toEntityPostId postKey, post')
