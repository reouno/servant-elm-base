{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedLabels  #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}

module Entity.Internal.User where

import           Control.Lens
import           Data.Extensible
import           Data.Text
import           Data.Time       ( UTCTime )

type User = Record '[ "name" >: Text, "email" >: Text, "createdAt" >: UTCTime]

type UserId = Int

type UserRecord = (UserId, User)

user1 :: User
user1 =
  #name @= "Neo" <: #email @= "neo@matrix.mov" <: #createdAt @=
  (read "1999-09-11 00:00:00" :: UTCTime) <:
  emptyRecord

{-
 - user1 ^. #name
 - --> "Neo"
 -}
user1Id :: UserId
user1Id = 1

user1Record :: UserRecord
user1Record = (user1Id, user1)

user2 :: User
user2 =
  #name @= "Morpheus" <: #email @= "morpheus@matrix.mov" <: #createdAt @=
  (read "1812-09-11 00:00:00" :: UTCTime) <:
  emptyRecord

user2Id :: UserId
user2Id = 2

user2Record :: UserRecord
user2Record = (user2Id, user2)
