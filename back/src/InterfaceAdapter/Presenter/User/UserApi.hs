{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}

module InterfaceAdapter.Presenter.User.UserApi where

import           Servant
import           ServantUtil   ( BaseCrudApi )

import           Entity.Entity ( User (..), UserId )

type UserApi = BaseCrudApi User UserId

userApi :: Proxy UserApi
userApi = Proxy
