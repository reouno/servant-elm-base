{-# LANGUAGE DataKinds        #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE TypeOperators    #-}

module InterfaceAdapter.PersistentStore.Model.Like.Adapter where

import           Control.Lens
import           Data.Extensible
import           Data.Time.Clock.POSIX                               ( posixSecondsToUTCTime,
                                                                       utcTimeToPOSIXSeconds )
import           Database.Persist.Sql
import           Database.Persist.Types                              ( Entity )

import           Entity.Entity                                       ( Like (..), LikeId,
                                                                       LikeRecord )
import qualified InterfaceAdapter.PersistentStore.Model              as M
import           InterfaceAdapter.PersistentStore.Model.Post.Adapter ( fromEntityPostId,
                                                                       toEntityPostId )
import           InterfaceAdapter.PersistentStore.Model.User.Adapter ( fromEntityUserId,
                                                                       toEntityUserId )
import           PersistentUtil                                      ( entity2Tuple, int2SqlKey,
                                                                       sqlKey2Int )

fromEntityLike :: Like -> M.Like
fromEntityLike like =
  M.Like
    (fromEntityPostId $ like ^. #postId)
    (fromEntityUserId $ like ^. #userId)
    (posixSecondsToUTCTime $ like ^. #createdAt)

fromEntityLikeId :: LikeId -> M.LikeId
fromEntityLikeId = int2SqlKey

toEntityLike :: M.Like -> Like
toEntityLike (M.Like postId userId createdAt) =
  #postId @= (sqlKey2Int postId) <: #userId @= (sqlKey2Int userId) <: #createdAt @=
  utcTimeToPOSIXSeconds createdAt <:
  emptyRecord

toEntityLikeId :: M.LikeId -> LikeId
toEntityLikeId = sqlKey2Int
