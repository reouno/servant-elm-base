{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module InterfaceAdapter.Presenter.Diary.DiaryApiHandler where

import           Control.Monad.IO.Class                    ( liftIO )
import           Servant

import           Entity.Entity                             ( Diary, DiaryId, diary1Record )
import           InterfaceAdapter.Presenter.Diary.DiaryApi ( DiaryApi )
import           ServantUtil                               ( BaseCrudApiPureHandler (..), Entity,
                                                             EntityKey )

instance Entity Diary

instance EntityKey DiaryId

instance BaseCrudApiPureHandler Diary DiaryId

diaryApiHandler :: Server DiaryApi
diaryApiHandler = baseCrudApiPureHandler [diary1Record]
