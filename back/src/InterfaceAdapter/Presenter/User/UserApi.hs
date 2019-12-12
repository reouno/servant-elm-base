{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}

module InterfaceAdapter.Presenter.User.UserApi where

import           Servant

import           Entity.Entity ( User (..), UserId, UserRecord, UserUniqueKey )
import           ServantUtil   ( BaseCrudApi )

type UserApi = UserBaseApi :<|> "user" :> UserManipulationApi

type UserBaseApi = BaseCrudApi User UserId

type UserManipulationApi
   = ReqBody '[ JSON] UserUniqueKey :> Post '[ JSON] (Maybe UserRecord)

userApi :: Proxy UserApi
userApi = Proxy
