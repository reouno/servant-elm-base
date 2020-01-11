module InterfaceAdapter.Presenter.Post.PostApi where

import           Servant       hiding ( Post )
import           ServantUtil   ( BaseCrudApi )

import           Entity.Entity ( Post (..), PostId )

type PostApi = BaseCrudApi Post PostId

userApi :: Proxy PostApi
userApi = Proxy
