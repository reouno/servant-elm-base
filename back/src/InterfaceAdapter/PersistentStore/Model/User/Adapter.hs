{-# LANGUAGE DataKinds        #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE TypeOperators    #-}

module InterfaceAdapter.PersistentStore.Model.User.Adapter where

import           Control.Lens
import           Data.Extensible

import           Entity.Entity                          ( User (..), UserId )
import qualified InterfaceAdapter.PersistentStore.Model as M
import           PersistentUtil                         ( int2SqlKey, sqlKey2Int )

toEntityUserId :: M.UserId -> UserId
toEntityUserId = sqlKey2Int

toEntityUser :: M.User -> User
toEntityUser (M.User name email createdAt) =
  #name @= name <: #email @= email <: #createdAt @= createdAt <: emptyRecord

fromEntityUserId :: UserId -> M.UserId
fromEntityUserId = int2SqlKey

fromEntityUser :: User -> M.User
fromEntityUser user =
  M.User (user ^. #name) (user ^. #email) (user ^. #createdAt)
