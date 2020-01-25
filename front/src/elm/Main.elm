module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Element exposing (Element, column, el, fill, padding, paragraph, rgb, text, width)
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Http
import Json.Decode as Decode exposing (Decoder, bool, field, int, list, string)
import Json.Decode.Pipeline exposing (required)
import RemoteData exposing (RemoteData(..), WebData)
import Time
import Url



{-
   - POST data
-}


type alias Post =
    { userId : Int
    , title : String
    , content : String
    , imageUrls : List String
    , allowAutoEdit : Bool
    , createdAt : Time.Posix
    , updatedAt : Time.Posix
    }


fetchPosts : Cmd Msg
fetchPosts =
    Http.get { url = "http://127.0.0.1:8080/posts", expect = Http.expectJson (RemoteData.fromResult >> GotPosts) postsDecoder }


timeDecoder : Decoder Time.Posix
timeDecoder =
    Decode.int
        |> Decode.andThen
            (\ms -> Decode.succeed <| Time.millisToPosix ms)


postsDecoder : Decoder (List Post)
postsDecoder =
    list <| entityDecoder postDecoder


entityDecoder : Decoder a -> Decoder a
entityDecoder decoder =
    field "entity" decoder


postDecoder : Decoder Post
postDecoder =
    Decode.succeed Post
        |> required "userId" int
        |> required "title" string
        |> required "content" string
        |> required "imageUrls" (list string)
        |> required "allowAutoEdit" bool
        |> required "createdAt" timeDecoder
        |> required "updatedAt" timeDecoder


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , posts : WebData (List Post)
    , newPost : String
    }


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | GotPosts (WebData (List Post))
    | ChangePostInput String


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model key url NotAsked "", fetchPosts )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }, Cmd.none )

        GotPosts response ->
            ( { model | posts = response }, Cmd.none )

        ChangePostInput newPost ->
            ( { model | newPost = newPost }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    { title = "Simple Post", body = elements model }


elements : Model -> List (Html Msg)
elements model =
    [ Element.layout [] (mainView model) ]


mainView : Model -> Element Msg
mainView model =
    column []
        [ helloMessage
        , postsView model.posts
        , inputPostView model.newPost
        ]


helloMessage : Element Msg
helloMessage =
    text "Hello, world."


postsView : WebData (List Post) -> Element Msg
postsView webData =
    case webData of
        NotAsked ->
            text "Nothing to do."

        Loading ->
            text "Loading posts..."

        Failure err ->
            text <| "Failed to load posts: " ++ Debug.toString err

        Success posts ->
            column [ width fill ] (List.map postView posts)


postView : Post -> Element Msg
postView post =
    column [ padding 5, Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }, Border.color <| rgb 0.6 0.6 0.6 ]
        [ paragraph [ Font.bold, padding 5 ] [ text post.title ]
        , paragraph [ padding 5 ] [ text post.content ]
        ]


inputPostView : String -> Element Msg
inputPostView newPost =
    column []
        [ Input.multiline [ width fill ] { label = Input.labelHidden "newPost", onChange = ChangePostInput, placeholder = Nothing, spellcheck = False, text = newPost } ]


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }
