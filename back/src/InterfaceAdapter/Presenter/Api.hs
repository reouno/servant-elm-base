{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}

module InterfaceAdapter.Presenter.Api where

import           Servant
import           ServantApi                              ( BaseCrudApi )

import           Entity.Entity
import           InterfaceAdapter.Presenter.User.UserApi ( UserApi (..) )

type Api = "users" :> UserApi

api :: Proxy Api
api = Proxy
