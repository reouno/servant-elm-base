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

get1User :: Int -> ReaderT SqlBackend IO (Maybe M.User)
get1User = get1Entity

runGet1User :: Int -> PgPool -> IO (Maybe M.User)
runGet1User id' = runSqlPool $ get1User id'

get1Diary :: Int -> ReaderT SqlBackend IO (Maybe M.Diary)
get1Diary = get1Entity

runGet1Diary :: Int -> PgPool -> IO (Maybe M.Diary)
runGet1Diary id' = runSqlPool $ get1Diary id'

get1DiaryImage :: Int -> ReaderT SqlBackend IO (Maybe M.DiaryImage)
get1DiaryImage = get1Entity

runGet1DiaryImage :: Int -> PgPool -> IO (Maybe M.DiaryImage)
runGet1DiaryImage id' = runSqlPool $ get1DiaryImage id'

runMultipleActionsInSingleTransaction :: PgPool -> IO (Maybe M.Diary)
runMultipleActionsInSingleTransaction pool =
  flip runSqlPool pool $ do
    get1User 1
    get1User 2
    get1Diary 1