{-# LANGUAGE GADTs               #-}
{-# LANGUAGE OverloadedLabels    #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators       #-}

module App.Util.Seeds where

import           Conduit                                               ( MonadUnliftIO )
import           Control.Lens
import           Control.Monad                                         ( forM_ )
import           Control.Monad.IO.Class                                ( liftIO )
import           Data.Extensible
import           Data.Text                                             hiding ( map )
import           Data.Time

import           Database.Persist.Sql

-- NOTE: This module must be imported as it has an instance implementation of `PersistentStore`.
--       This is a big demerit of separation of type declaration and instance implementation.
import           InterfaceAdapter.PersistentStore.Infra.Postgres

import           Entity.Entity                                         ( Post (..), User (..) )
import           InterfaceAdapter.PersistentStore.Infra.Postgres.Types ( PgPool )
import qualified InterfaceAdapter.PersistentStore.Model                as M
import           InterfaceAdapter.PersistentStore.Model.Diary.Adapter  ( fromEntityDiary )
import           InterfaceAdapter.PersistentStore.Model.User.Adapter   ( fromEntityUser )
import           Usecase.Interface.PersistentStore.PersistentStore     ( PersistentStore (doMigration, withPool) )

main :: IO ()
main = plantSeeds

plantSeeds :: IO ()
plantSeeds =
  withPool $ \(pool :: PgPool) -> do
    putStrLn "seeds were planted."
    insertUsers pool
    insertDiaries pool

insertUsers :: PgPool -> IO ()
insertUsers pool =
  forM_ users $ \user -> runSqlPool (insert_ . fromEntityUser $ user) pool

insertDiaries :: PgPool -> IO ()
insertDiaries pool =
  forM_ (map fromEntityDiary diaries) $ \(diary, images) -> do
    diaryId <- runSqlPool (insert diary) pool
    forM_ images $ \image ->
      runSqlPool (insert_ $ M.PostImage diaryId image) pool

users :: [User]
users = [user1, user2, user3]

user1 :: User
user1 =
  #name @= "Neo" <: #email @= "neo@matrix.mov" <: #createdAt @=
  (read "1999-09-11 00:00:00" :: UTCTime) <:
  emptyRecord

user2 :: User
user2 =
  #name @= "Morpheus" <: #email @= "morpheus@matrix.mov" <: #createdAt @=
  (read "1812-09-11 00:00:00" :: UTCTime) <:
  emptyRecord

user3 :: User
user3 =
  #name @= "Trinity" <: #email @= "trinity@matrix.mov" <: #createdAt @=
  (read "1995-12-31 12:13:14" :: UTCTime) <:
  emptyRecord

diaries :: [Post]
diaries = [diary1, diary2]

diary1 :: Post
diary1 =
  #title @= "AutoDiary" <: #content @=
  "This is the first diary which is generated by Apricot. Images may be included in it as well." <:
  #imageUrls @=
  [ "https://upload.wikimedia.org/wikipedia/commons/c/c4/Apricot_fruit.jpg"
  , "https://bedemco.com/bdc/wp-content/uploads/2017/12/shutterstock_178969106-1-1-570x385.jpg"
  ] <:
  #allowAutoEdit @=
  True <:
  #createdAt @=
  (read "2019-11-11 11:11:11" :: UTCTime) <:
  #updatedAt @=
  (read "2019-11-11 11:11:11" :: UTCTime) <:
  #userId @=
  1 <:
  emptyRecord

diary2 :: Post
diary2 =
  #title @= "Define your personal mission in life!" <: #content @=
  "The key insights from The 7 Habits of Highly Effective People:\n\
  \1. Sharpen the saw\n\
  \2. Be proactive\n\
  \3. Begin with an end in mind\n\
  \4. Pu first things first\n\
  \5. Think win-win\n\
  \6. Seek first to understand, then to be understood\n\
  \7. Synergize\n" <:
  #imageUrls @=
  [ "https://m.media-amazon.com/images/I/51OuvCFwyZL._SL500_.jpg"
  , "https://archive.sltrib.com/images/2012/0717/biz_obit-covey_071712~2.jpg"
  ] <:
  #allowAutoEdit @=
  True <:
  #createdAt @=
  (read "2019-11-11 11:11:11" :: UTCTime) <:
  #updatedAt @=
  (read "2019-11-11 11:11:11" :: UTCTime) <:
  #userId @=
  2 <:
  emptyRecord
