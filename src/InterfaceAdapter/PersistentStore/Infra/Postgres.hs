{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GADTs             #-}
{-# LANGUAGE InstanceSigs      #-}

module InterfaceAdapter.PersistentStore.Infra.Postgres where

import           Control.Monad.IO.Class                                       ( liftIO )
import           Control.Monad.Logger                                         ( runStderrLoggingT )
import           Data.Yaml.Config                                             ( loadYamlSettings,
                                                                                useEnv )
import           Database.Persist.Postgresql

import           InterfaceAdapter.PersistentStore.Infra.Postgres.Types        ( PgPool )
import           InterfaceAdapter.PersistentStore.Model                       ( migrateAll )
import           InterfaceAdapter.PersistentStore.Model.Like.LikeStoreHandler
import           InterfaceAdapter.PersistentStore.Model.Post.PostStoreHandler
import           InterfaceAdapter.PersistentStore.Model.User.UserStoreHandler
import           Usecase.Interface.PersistentStore.PersistentStore            ( PersistentStore (..) )

instance PersistentStore PgPool where
  withPool = withPgPool
  doMigration = doPgMigration

pgConf :: IO PostgresConf
pgConf = loadYamlSettings ["config/database-setting.yml"] [] useEnv

withPgPool :: (PgPool -> IO a) -> IO a
withPgPool app = do
  conf <- pgConf
  runStderrLoggingT $
    withPostgresqlPool (pgConnStr conf) (pgPoolSize conf) $ \pool ->
      liftIO $ app pool

doPgMigration :: PgPool -> IO ()
doPgMigration = runSqlPersistMPool $ runMigration migrateAll
