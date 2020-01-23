{-# LANGUAGE DataKinds        #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE TypeOperators    #-}

module Entity.Internal.Post where

import           Control.Lens
import           Data.Extensible
import           Data.Text
import           Data.Time.Clock.POSIX ( POSIXTime )
import           Entity.Internal.User  ( UserId )

type Post
   = Record '[ "title" >: Text, "content" >: Text, "imageUrls" >: [Text], "allowAutoEdit" >: Bool, "createdAt" >: POSIXTime, "updatedAt" >: POSIXTime, "userId" >: UserId]

type PostId = Int

type PostRecord = (PostId, Post)
