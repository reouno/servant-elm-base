{-# LANGUAGE FlexibleContexts    #-}
{-# LANGUAGE FlexibleInstances   #-}
{-# LANGUAGE GADTs               #-}
{-# LANGUAGE ScopedTypeVariables #-}

-- {-# LANGUAGE MultiParamTypeClasses #-}
module InterfaceAdapter.PersistentStore.Model.User.UserStoreHandler where

import           Conduit                        ( MonadUnliftIO )
import           Control.Monad.IO.Class         ( MonadIO )
import           Data.Pool                      ( Pool )
import           Database.Persist
import           Database.Persist.Sql
import           PersistentUtil                 ( delete'
                                                , entity2Tuple
                                                , get'
                                                , getBy'
                                                , insert'
                                                , replace'
                                                , selectList'
                                                )

-- import           InterfaceAdapter.PersistentStore.Model
import           Entity.Entity
import           InterfaceAdapter.PersistentStore.Infra.Postgres.Types
                                                ( PgPool )
import           InterfaceAdapter.PersistentStore.Model.User.Adapter
                                                ( fromEntityUser
                                                , fromEntityUserId
                                                , fromEntityUserUniqueKey
                                                , toEntityUser
                                                , toEntityUserId
                                                , toEntityUserRecord
                                                )
import           Usecase.Interface.User.UserStore
                                                ( UserStore(..) )

instance UserStore PgPool where
  getUsers pool = map (adapter . entity2Tuple) <$> selectList' pool
    where adapter (a, b) = (a, toEntityUser b)
  getUser pool key = fmap toEntityUser <$> get' (fromEntityUserId key) pool
  getUserBy pool uniqueKey =
    fmap toEntityUserRecord <$> getBy' (fromEntityUserUniqueKey uniqueKey) pool
  newUser pool now user =
    toEntityUserId <$> insert' (fromEntityUser now user) pool
  replaceUser pool now id' user =
    replace' (fromEntityUserId id') (fromEntityUser now user) pool
  deleteUser pool id' = delete' (fromEntityUserId id') pool
