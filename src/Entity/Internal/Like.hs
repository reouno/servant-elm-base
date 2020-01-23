{-# LANGUAGE DataKinds        #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE TypeOperators    #-}

module Entity.Internal.Like where

import           Control.Lens
import           Data.Extensible
import           Data.Text
import           Data.Time.Clock.POSIX ( POSIXTime )

import           Entity.Internal.Post  ( PostId )
import           Entity.Internal.User  ( UserId )

type Like
   = Record '[ "postId" >: PostId, "userId" >: UserId, "createdAt" >: POSIXTime]

type LikeId = Int

type LikeRecord = (LikeId, Like)
