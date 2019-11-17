{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module InterfaceAdapter.Presenter.User.UserApiHandler where

import           Control.Monad.IO.Class                  ( liftIO )
import           Servant

import           Entity.Entity                           ( User, UserId, user1Record )
import           InterfaceAdapter.Presenter.User.UserApi ( UserApi )
import           ServantUtil                             ( BaseCrudApiPureHandler (..), Entity,
                                                           EntityKey )

instance Entity User

instance EntityKey UserId

instance BaseCrudApiPureHandler User UserId

userApiHandler :: Server UserApi
userApiHandler = baseCrudApiPureHandler [user1Record]
