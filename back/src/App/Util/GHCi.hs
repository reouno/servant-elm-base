{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GADTs             #-}
{-# LANGUAGE InstanceSigs      #-}

module App.Util.GHCi where

import           Control.Monad.Logger                                         ( runStderrLoggingT )
import           Control.Monad.Reader                                         ( ReaderT )
import           Database.Persist.Class
import           Database.Persist.Postgresql
import           Database.Persist.Sql
import           PersistentUtil                                               ( int2SqlKey )

import           InterfaceAdapter.PersistentStore.Infra.Postgres              ( pgConf )
import           InterfaceAdapter.PersistentStore.Infra.Postgres.Types        ( PgPool )
import qualified InterfaceAdapter.PersistentStore.Model                       as M
import           InterfaceAdapter.PersistentStore.Model.User.UserStoreHandler

createPgPool :: IO PgPool
createPgPool = do
  conf <- pgConf
  runStderrLoggingT $ createPostgresqlPool (pgConnStr conf) 10

get1Entity ::
     ( PersistEntity record
     , ToBackendKey SqlBackend record
     , PersistEntityBackend record ~ SqlBackend
     )
  => Int
  -> ReaderT SqlBackend IO (Maybe record)
get1Entity id' = get $ int2SqlKey id'

{-
 - User utility
 -}
get1User :: Int -> ReaderT SqlBackend IO (Maybe M.User)
get1User = get1Entity

runGet1User :: Int -> PgPool -> IO (Maybe M.User)
runGet1User id' = runSqlPool $ get1User id'

runGetUsers :: PgPool -> IO [Entity M.User]
runGetUsers = runSqlPool $ selectList [] []

{-
 - Post utility
 -}
get1Post :: Int -> ReaderT SqlBackend IO (Maybe M.Post)
get1Post = get1Entity

runGet1Post :: Int -> PgPool -> IO (Maybe M.Post)
runGet1Post id' = runSqlPool $ get1Post id'

runGetPosts :: PgPool -> IO [Entity M.Post]
runGetPosts = runSqlPool $ selectList [] []

{-
 - PostImage utility
 -}
get1PostImage :: Int -> ReaderT SqlBackend IO (Maybe M.PostImage)
get1PostImage = get1Entity

runGet1PostImage :: Int -> PgPool -> IO (Maybe M.PostImage)
runGet1PostImage id' = runSqlPool $ get1PostImage id'

runGetPostImages :: PgPool -> IO [Entity M.PostImage]
runGetPostImages = runSqlPool $ selectList [] []

getPostImagesWithConditions :: Int -> PgPool -> IO [Entity M.PostImage]
getPostImagesWithConditions id' =
  runSqlPool (selectList [M.PostImagePostId ==. int2SqlKey id'] [LimitTo 3])

{-
 - Others
 -}
runMultipleActionsInSingleTransaction :: PgPool -> IO (Maybe M.Post)
runMultipleActionsInSingleTransaction pool =
  flip runSqlPool pool $ do
    get1User 1
    get1User 2
    get1Post 1
