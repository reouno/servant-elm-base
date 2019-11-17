{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}

module InterfaceAdapter.Presenter.Api where

import           Servant
import           ServantUtil                               ( BaseCrudApi )

import           Entity.Entity
import           InterfaceAdapter.Presenter.Diary.DiaryApi ( DiaryApi (..) )
import           InterfaceAdapter.Presenter.User.UserApi   ( UserApi (..) )

type Api = "users" :> UserApi :<|> "diaries" :> DiaryApi

api :: Proxy Api
api = Proxy
