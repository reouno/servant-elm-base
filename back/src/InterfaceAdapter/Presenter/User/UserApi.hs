{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}

module InterfaceAdapter.Presenter.User.UserApi where

import           Servant
import           ServantApi    ( BaseCrudApi )

import           Entity.Entity ( User (..) )

type UserApi = BaseCrudApi User Int

-- type UserApi = Get '[ JSON] [(Int, User)]
userApi :: Proxy UserApi
userApi = Proxy
