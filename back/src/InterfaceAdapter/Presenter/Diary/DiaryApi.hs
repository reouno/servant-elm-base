module InterfaceAdapter.Presenter.Diary.DiaryApi where

import           Servant       hiding ( Post )
import           ServantUtil   ( BaseCrudApi )

import           Entity.Entity ( Post (..), PostId )

type DiaryApi = BaseCrudApi Post PostId

userApi :: Proxy DiaryApi
userApi = Proxy
