{-# LANGUAGE FlexibleContexts    #-}
{-# LANGUAGE FlexibleInstances   #-}
{-# LANGUAGE GADTs               #-}
{-# LANGUAGE OverloadedLabels    #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators       #-}

module InterfaceAdapter.PersistentStore.Model.Diary.DiaryStoreHandler where

import           Conduit                                               ( MonadUnliftIO )
import           Control.Monad.IO.Class                                ( liftIO )
import           Control.Monad.Reader                                  ( ReaderT )
import           Database.Persist
import           Database.Persist.Sql

import           Entity.Entity                                         ( DiaryRecord )
import           InterfaceAdapter.PersistentStore.Infra.Postgres.Types ( PgPool )
import qualified InterfaceAdapter.PersistentStore.Model                as M
import           InterfaceAdapter.PersistentStore.Model.Diary.Adapter  ( fromEntityDiary,
                                                                         fromEntityDiaryId,
                                                                         toEntityDiary',
                                                                         toEntityDiaryId )
import           Usecase.Interface.Diary.DiaryStore                    ( DiaryStore (..) )

instance DiaryStore PgPool where
  getDiaries pool =
    flip runSqlPool pool $ do
      (diaries :: [Entity M.Diary]) <- selectList [] []
      mapM joinImages2Diary diaries
  newDiary pool diary = do
    let (diary', images) = fromEntityDiary diary
    flip runSqlPool pool $ do
      diaryId <- insert diary'
      mapM_ (insert_ . M.DiaryImage diaryId) images
      liftIO . return $ toEntityDiaryId diaryId
  getDiary pool diaryId =
    flip runSqlPool pool $ do
      let diaryKey = fromEntityDiaryId diaryId
      mayDiary <- get diaryKey
      case mayDiary of
        Just diary -> do
          images <- selectList [M.DiaryImageDiaryId ==. diaryKey] []
          liftIO . return . Just $ toEntityDiary' diary $ map entityVal images
        Nothing -> liftIO $ return Nothing
  replaceDiary pool diaryId diary =
    flip runSqlPool pool $ do
      let (diary', images) = fromEntityDiary diary
          diaryKey = fromEntityDiaryId diaryId
      replace diaryKey diary'
      deleteWhere [M.DiaryImageDiaryId ==. diaryKey]
      mapM_ (insert_ . M.DiaryImage diaryKey) images
  deleteDiary pool diaryId =
    flip runSqlPool pool $ do
      let diaryKey = fromEntityDiaryId diaryId
      delete diaryKey
      deleteWhere [M.DiaryImageDiaryId ==. diaryKey]

joinImages2Diary ::
     MonadUnliftIO m => Entity M.Diary -> ReaderT SqlBackend m DiaryRecord
joinImages2Diary diary = do
  let diaryKey = entityKey diary
  images <- selectList [M.DiaryImageDiaryId ==. diaryKey] []
  let diary' = toEntityDiary' (entityVal diary) $ map entityVal images
  return (toEntityDiaryId diaryKey, diary')
