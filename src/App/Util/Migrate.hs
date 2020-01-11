{-# LANGUAGE ScopedTypeVariables #-}

module App.Util.Migrate where

import           InterfaceAdapter.PersistentStore.Infra.Postgres
import           InterfaceAdapter.PersistentStore.Infra.Postgres.Types ( PgPool )
import           Usecase.Interface.PersistentStore.PersistentStore     ( PersistentStore (doMigration, withPool) )

main :: IO ()
main = runMigration

runMigration :: IO ()
runMigration = withPool $ \(pool :: PgPool) -> doMigration pool
