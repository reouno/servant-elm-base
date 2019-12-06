module App.Server where

import           Servant

import           InterfaceAdapter.Controller.PlainUserServer           ( plainUserServer )
import           InterfaceAdapter.PersistentStore.Infra.Postgres
import           InterfaceAdapter.PersistentStore.Infra.Postgres.Types ( PgPool )
import           InterfaceAdapter.Presenter.Api                        ( Api, api )
import           InterfaceAdapter.Presenter.Diary.DiaryApiHandler      ( diaryApiHandler )
import           Usecase.Interface.PersistentStore.PersistentStore     ( PersistentStore (doMigration, mkPool) )

server :: PersistentStore pool => pool -> Server Api
server pool = plainUserServer pool :<|> diaryApiHandler

app :: PersistentStore pool => pool -> Application
app pool = serve api $ server pool

mkApp :: IO Application
mkApp = do
  pool <- mkPool :: IO PgPool
  doMigration pool
  return $ app pool
