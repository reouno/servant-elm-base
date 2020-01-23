{-# LANGUAGE DataKinds        #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE TypeOperators    #-}

module InterfaceAdapter.PersistentStore.Model.User.Adapter where

import           Control.Lens
import           Data.Extensible
import           Data.Text
import           Data.Time.Clock.POSIX                  ( posixSecondsToUTCTime,
                                                          utcTimeToPOSIXSeconds )
import           Database.Persist.Sql                   ( entityKey, entityVal )
import           Database.Persist.Types                 ( Entity )

import           Entity.Entity                          ( User (..), UserId, UserRecord,
                                                          UserUniqueKey )
import qualified InterfaceAdapter.PersistentStore.Model as M
import           PersistentUtil                         ( entity2Tuple, int2SqlKey, sqlKey2Int )

fromEntityUserId :: UserId -> M.UserId
fromEntityUserId = int2SqlKey

fromEntityUserUniqueKey :: UserUniqueKey -> M.Unique M.User
fromEntityUserUniqueKey = M.UniqueEmail

fromEntityUser :: User -> M.User
fromEntityUser user =
  M.User
    (user ^. #name)
    (user ^. #email)
    (posixSecondsToUTCTime $ user ^. #createdAt)

toEntityUserId :: M.UserId -> UserId
toEntityUserId = sqlKey2Int

toEntityUserUniqueKey :: M.Unique M.User -> UserUniqueKey
toEntityUserUniqueKey (M.UniqueEmail email) = email

toEntityUser :: M.User -> User
toEntityUser (M.User name email createdAt) =
  #name @= name <: #email @= email <: #createdAt @=
  utcTimeToPOSIXSeconds createdAt <:
  emptyRecord

toEntityUserRecord :: Entity M.User -> UserRecord
toEntityUserRecord user =
  (toEntityUserId . entityKey $ user, toEntityUser . entityVal $ user)
