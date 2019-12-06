{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE InstanceSigs      #-}

module InterfaceAdapter.PersistentStore.Infra.Postgres where

import           Control.Monad.Logger                                         ( runStdoutLoggingT )
import           Control.Monad.Trans.Reader                                   ( runReaderT )
import           Control.Monad.Trans.Resource                                 ( runResourceT )
import           Data.Yaml.Config                                             ( loadYamlSettings,
                                                                                useEnv )
import           Database.Persist.Postgresql
import           Database.Persist.Sql

import           InterfaceAdapter.PersistentStore.Infra.Postgres.Types        ( PgPool )
import           InterfaceAdapter.PersistentStore.Model                       ( migrateAll )
import           InterfaceAdapter.PersistentStore.Model.User.UserStoreHandler
import           Usecase.Interface.PersistentStore.PersistentStore            ( PersistentStore (..) )

instance PersistentStore PgPool where
  mkPool = pgPool
  doMigration = doPgMigration

pgConf :: IO PostgresConf
pgConf = loadYamlSettings ["config/database-setting.yml"] [] useEnv

pgPool :: IO PgPool
pgPool = do
  conf <- pgConf
  runStdoutLoggingT $ createPostgresqlPool (pgConnStr conf) (pgPoolSize conf)

doPgMigration :: PgPool -> IO ()
doPgMigration = runSqlPool $ runMigration migrateAll
