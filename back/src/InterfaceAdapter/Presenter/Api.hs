{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}

module InterfaceAdapter.Presenter.Api where

import           Servant
import           ServantUtil                             ( BaseCrudApi )

import           Entity.Entity
import           InterfaceAdapter.Presenter.Post.PostApi ( PostApi (..) )
import           InterfaceAdapter.Presenter.User.UserApi ( UserApi (..) )

type Api = "users" :> UserApi :<|> "posts" :> PostApi

api :: Proxy Api
api = Proxy
