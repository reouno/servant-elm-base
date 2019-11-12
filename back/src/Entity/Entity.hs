{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedLabels  #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}

module Entity.Entity where

import           Control.Lens
import           Data.Extensible
import           Data.Text
import           Data.Time       ( UTCTime )

type User = Record '[ "name" >: Text, "email" >: Text, "createdAt" >: UTCTime]

type Diary
   = Record '[ "title" >: Text, "content" >: Text, "imageUrls" >: [Text], "allowAutoEdit" >: Bool, "createdAt" >: UTCTime, "updatedAt" >: UTCTime]

user1 :: User
user1 =
  #name @= "Neo" <: #email @= "neo@matrix.mov" <: #createdAt @=
  (read "1999-09-11 00:00:00" :: UTCTime) <:
  emptyRecord
{-
 - user1 ^. #name
 - --> "Neo"
 -}
