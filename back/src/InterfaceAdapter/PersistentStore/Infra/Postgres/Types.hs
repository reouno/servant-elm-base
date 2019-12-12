module InterfaceAdapter.PersistentStore.Infra.Postgres.Types where

import           Database.Persist.Sql

-- FIXME: need not to constrain this type to PostgresQL, or the specific infrastructure
--        this type definition should be in upper layer than the `Infra`
type PgPool = ConnectionPool
