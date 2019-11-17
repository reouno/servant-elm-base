module InterfaceAdapter.Presenter.Diary.DiaryApi where

import           Servant
import           ServantUtil   ( BaseCrudApi )

import           Entity.Entity ( Diary (..), DiaryId )

type DiaryApi = BaseCrudApi Diary DiaryId

userApi :: Proxy DiaryApi
userApi = Proxy
