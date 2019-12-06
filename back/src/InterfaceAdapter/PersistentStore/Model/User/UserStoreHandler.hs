{-# LANGUAGE FlexibleContexts    #-}
{-# LANGUAGE FlexibleInstances   #-}
{-# LANGUAGE GADTs               #-}
{-# LANGUAGE ScopedTypeVariables #-}

-- {-# LANGUAGE MultiParamTypeClasses #-}
module InterfaceAdapter.PersistentStore.Model.User.UserStoreHandler where

import           Conduit                                               ( MonadUnliftIO )
import           Control.Monad.IO.Class                                ( MonadIO )
import           Data.Pool                                             ( Pool )
import           Database.Persist
import           Database.Persist.Sql
import           PersistentUtil                                        ( delete', entity2Tuple,
                                                                         get', insert', replace',
                                                                         selectList' )

-- import           InterfaceAdapter.PersistentStore.Model
import           Entity.Entity
import           InterfaceAdapter.PersistentStore.Infra.Postgres.Types ( PgPool )
import           InterfaceAdapter.PersistentStore.Model.User.Adapter   ( fromEntityUser,
                                                                         fromEntityUserId,
                                                                         toEntityUser,
                                                                         toEntityUserId )
import           Usecase.Interface.User.UserStore                      ( UserStore (..) )

instance UserStore PgPool where
  getUsers pool = map (adapter . entity2Tuple) <$> selectList' pool
    where
      adapter (a, b) = (a, toEntityUser b)
  getUser pool key = fmap toEntityUser <$> get' (fromEntityUserId key) pool
  newUser pool user = toEntityUserId <$> insert' (fromEntityUser user) pool
  replaceUser pool id' user =
    replace' (fromEntityUserId id') (fromEntityUser user) pool
  deleteUser pool id' = delete' (fromEntityUserId id') pool
