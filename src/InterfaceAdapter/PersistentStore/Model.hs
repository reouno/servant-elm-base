{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE InstanceSigs               #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE StandaloneDeriving         #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}

module InterfaceAdapter.PersistentStore.Model where

import           Data.Text
import           Data.Time            ( UTCTime )
import           Database.Persist
import           Database.Persist.Sql
import           Database.Persist.TH
import           GHC.Generics         ( Generic )

share
  [mkPersist sqlSettings, mkMigrate "migrateAll"]
  [persistLowerCase|
User json
    name Text
    email Text
    UniqueEmail email
    createdAt UTCTime default=CURRENT_TIMESTAMP
    deriving Read Eq Generic Show
Post json
    userId UserId
    title Text
    content Text
    allowAutoEdit Bool
    createdAt UTCTime default=CURRENT_TIMESTAMP
    updatedAt UTCTime default=CURRENT_TIMESTAMP
    deriving Read Eq Generic Show
PostImage json
    postId PostId
    url Text
    deriving Read Eq Generic Show
Like json
    postId PostId
    userId UserId
    createdAt UTCTime default=CURRENT_TIMESTAMP
    deriving Read Eq Generic Show
|]
