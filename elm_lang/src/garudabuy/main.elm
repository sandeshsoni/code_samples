module Main exposing (..)
import Browser exposing (Document)
import Url exposing (Url)
import Json.Decode as Decode exposing (Value)
import Browser.Navigation as Nav

import Garudabuy.Route exposing (..)
import Garudabuy.Route as Route exposing (Route)
import Garudabuy.Session as Session exposing (Session)
import Garudabuy.Viewer as Viewer exposing (Viewer)
import Garudabuy.Api as Api exposing (Cred)
import Garudabuy.Page as Page exposing (..)

import Garudabuy.Page.Home as Home
import Garudabuy.Page.Blank as Blank
import Garudabuy.Page.NotFound as NotFound


import Html exposing (text, div)

type Model
    = Home Home.Model
    | Admin Home.Model
    | Redirect Session
    | NotFound Session



-- - Model, Cmd
init : Maybe Viewer -> Url -> Nav.Key -> (Model, Cmd Msg)
-- init : Url -> Nav.Key -> (Model, Cmd Msg)
-- init : Url -> (Model, Cmd Msg)
init maybeViewer url navKey =
    -- ({}, Cmd.none)
    -- Home.init
    changeRouteTo (Route.fromUrl url)
        (Redirect (Session.fromViewer navKey maybeViewer))

-- changeRouteTo
changeRouteTo : Maybe Route -> Model -> (Model, Cmd Msg)
changeRouteTo maybeRoute model =
    let
        session = toSession model
    in
        case maybeRoute of
            Nothing ->
                (NotFound session, Cmd.none)

            Just Route.Home ->
                Home.init session
                    |> updateWith Home GotHomeMsg model
            Just Route.Admin ->
                Home.init session
                    |> updateWith Home GotHomeMsg model


updateWith : (subModel -> Model) -> (subMsg -> Msg) -> Model -> (subModel, Cmd subMsg) -> (Model, Cmd Msg)
updateWith toModel toMsg model(subModel, subCmd) =
    ( toModel subModel
    , Cmd.map toMsg subCmd
    )


toSession : Model -> Session
toSession page =
    case page of
        Redirect session ->
            session
        Home home ->
            Home.toSession home
        NotFound session ->
            session
        Admin admin ->
            Home.toSession admin

type Msg
    = GotHomeMsg Home.Msg
    | GotAdminMsg Home.Msg
    | ClickedLink Browser.UrlRequest
    | ChangedUrl Url
    | Ignored



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case (msg, model) of
        (GotHomeMsg subMsg, Home home) ->
            Home.update subMsg home
                 |> updateWith Home GotHomeMsg model
        (GotAdminMsg subMsg,  Admin admin) ->
            Home.update subMsg admin
                 |> updateWith Home GotHomeMsg model
        (ClickedLink urlRequest, _)  ->
            case urlRequest of
                Browser.Internal url ->
                    (model,
                         Nav.pushUrl (Session.navKey (toSession model)) (Url.toString url))
                Browser.External url ->
                    (model,
                         Nav.load url)
        (ChangedUrl url, _ ) ->
            changeRouteTo (Route.fromUrl url) model
        (Ignored, _) ->
            (model, Cmd.none)
        (_,_) ->
            (model, Cmd.none)


-- - pageView

view : Model -> Document Msg
view model =
    let
        viewPage page toMsg config =
            let
                {title, body} =
                    Page.view (Session.viewer (toSession model)) page config
                in
                { title = title
                , body = List.map (Html.map toMsg) body
                }
    in
    case model of
        Home home ->
    -- div[][text "hello"]
            viewPage Page.Home GotHomeMsg (Home.view home)
    -- { title = "hi page"
    -- , content = div[][text "hello"]
    -- , body = List.map (Html.map toMsg) text "hello"
    -- }
        Admin admin ->
            viewPage Page.Home GotHomeMsg (Home.view admin)
    -- Non page models
        NotFound _ ->
            viewPage Page.Other(\_ -> Ignored) Blank.view
        Redirect _ ->
            viewPage Page.Other(\_ -> Ignored) NotFound.view

-- no subscriptions for now


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

-- viewPage

main : Program Value Model Msg
main = Api.application Viewer.decoder
       { init = init
       , onUrlRequest = ClickedLink
       , onUrlChange = ChangedUrl
       , update = update
       , subscriptions = subscriptions
       , view = view
       }
