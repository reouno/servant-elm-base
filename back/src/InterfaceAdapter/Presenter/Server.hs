module InterfaceAdapter.Presenter.Server where

import           Servant

import           InterfaceAdapter.Presenter.Api                 ( Api, api )
import           InterfaceAdapter.Presenter.User.UserApiHandler ( userApiHandler )

server :: Server Api
server = userApiHandler

app :: Application
app = serve api server
