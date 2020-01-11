{-# LANGUAGE FlexibleContexts    #-}
{-# LANGUAGE FlexibleInstances   #-}
{-# LANGUAGE GADTs               #-}
{-# LANGUAGE OverloadedLabels    #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators       #-}

module InterfaceAdapter.PersistentStore.Model.Like.LikeStoreHandler where

import           Database.Persist
import           Database.Persist.Sql

import           Entity.Entity                                         ( Like (..), LikeRecord )
import           InterfaceAdapter.PersistentStore.Infra.Postgres.Types ( PgPool )
import qualified InterfaceAdapter.PersistentStore.Model                as M
import           InterfaceAdapter.PersistentStore.Model.Like.Adapter   ( fromEntityLike,
                                                                         fromEntityLikeId,
                                                                         toEntityLike,
                                                                         toEntityLikeId )
import           Usecase.Interface.Like.LikeStore                      ( LikeStore (..) )

instance LikeStore PgPool where
  getLikes pool =
    flip runSqlPool pool $ do
      (likes :: [Entity M.Like]) <- selectList [] []
      return $
        map
          (\like ->
             ( toEntityLikeId . entityKey $ like
             , toEntityLike . entityVal $ like))
          likes
  newLike pool like =
    flip runSqlPool pool $ toEntityLikeId <$> insert (fromEntityLike like)
  getLike pool likeId =
    flip runSqlPool pool $ fmap toEntityLike <$> get (fromEntityLikeId likeId)
  deleteLike pool likeId =
    flip runSqlPool pool $ delete (fromEntityLikeId likeId)
