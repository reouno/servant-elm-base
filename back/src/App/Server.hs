{-# LANGUAGE ScopedTypeVariables #-}

module App.Server where

import           Control.Monad.IO.Class                                ( liftIO )
import           Servant

import           InterfaceAdapter.Controller.UserApiHandler            ( userApiHandler )
import           InterfaceAdapter.PersistentStore.Infra.Postgres

import           InterfaceAdapter.Controller.DiaryApiHandler           ( diaryApiHandler )
import           InterfaceAdapter.PersistentStore.Infra.Postgres.Types ( PgPool )
import           InterfaceAdapter.Presenter.Api                        ( Api, api )
import           Usecase.Interface.PersistentStore.PersistentStore     ( PersistentStore (withPool) )

server :: PersistentStore pool => pool -> Server Api
server pool = userApiHandler pool :<|> diaryApiHandler pool

app :: PersistentStore pool => pool -> Application
app pool = serve api $ server pool

mkApp :: IO Application
mkApp = withPool $ \(pool :: PgPool) -> return $ app pool
