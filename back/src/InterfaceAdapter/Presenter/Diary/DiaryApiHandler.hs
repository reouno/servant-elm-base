{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module InterfaceAdapter.Presenter.Diary.DiaryApiHandler where

import           Control.Monad.IO.Class                    ( liftIO )
import           Servant

-- FIXME: Remove this dependency ASAP!
import           App.Util.Seeds                            ( diary1 )

import           Entity.Entity                             ( Diary, DiaryId )
import           InterfaceAdapter.Presenter.Diary.DiaryApi ( DiaryApi )
import           ServantUtil                               ( BaseCrudApiPureHandler (..), Entity,
                                                             EntityKey )

instance Entity Diary

instance EntityKey DiaryId

instance BaseCrudApiPureHandler Diary DiaryId

diaryApiHandler :: Server DiaryApi
diaryApiHandler = baseCrudApiPureHandler [diary1Record]

diary1Record :: (DiaryId, Diary)
diary1Record = (1, diary1)
