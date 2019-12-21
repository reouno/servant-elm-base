{-# LANGUAGE DataKinds        #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE TypeOperators    #-}

module Entity.Internal.User where

import           Control.Lens
import           Data.Extensible
import           Data.Text
import           Data.Time       ( UTCTime )

type Email = Text

type UserUniqueKey = Email

type User = Record '[ "name" >: Text, "email" >: Email, "createdAt" >: UTCTime]

type UserId = Int

type UserRecord = (UserId, User)
