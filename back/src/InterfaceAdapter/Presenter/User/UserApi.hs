{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}

module InterfaceAdapter.Presenter.User.UserApi where

import           Servant

import           Entity.Entity ( User (..), UserId )
import           ServantUtil   ( BaseCrudApi )

type UserApi = BaseCrudApi User UserId

--type UserApi = Get '[ JSON] [(UserId, User)]
userApi :: Proxy UserApi
userApi = Proxy
