module InterfaceAdapter.Controller.DiaryApiHandler where

import           Control.Monad.IO.Class                            ( liftIO )
import           Servant                                           ( (:<|>) (..), NoContent (..),
                                                                     Server )

import           InterfaceAdapter.Presenter.Diary.DiaryApi         ( DiaryApi )
import           Usecase.Interactor.PlainDiaryServer               ( deleteDiary, getDiaries,
                                                                     getDiary, newDiary,
                                                                     replaceDiary )
import           Usecase.Interface.PersistentStore.PersistentStore ( PersistentStore )

diaryApiHandler :: PersistentStore pool => pool -> Server DiaryApi
diaryApiHandler pool = getEntities pool :<|> newEntity pool :<|> operations pool
  where
    getEntities = liftIO . getDiaries
    newEntity pool user = liftIO $ newDiary pool user >> return NoContent
    operations pool id' =
      getEntity pool id' :<|> updateEntity pool id' :<|> deleteEntity pool id'
    getEntity pool id' = liftIO $ getDiary pool id'
    updateEntity pool id' user =
      liftIO $ replaceDiary pool id' user >> return NoContent
    deleteEntity pool id' = liftIO $ deleteDiary pool id' >> return NoContent
