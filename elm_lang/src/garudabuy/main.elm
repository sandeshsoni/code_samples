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
import Garudabuy.Page.Admin as Admin
import Garudabuy.Page.Blank as Blank
import Garudabuy.Page.NotFound as NotFound
import Garudabuy.Page.Login as Login
import Garudabuy.Page.Register as Register
import Garudabuy.Page.Article.Editor as Editor

import Html exposing (text, div)

type Model
    = Home Home.Model
    | Admin Admin.Model
    | Login Login.Model
    | Register Register.Model
    | Editor Editor.Model
    | Redirect Session
    | NotFound Session



-- - Model, Cmd
init : Maybe Viewer -> Url -> Nav.Key -> (Model, Cmd Msg)
-- init : Url -> Nav.Key -> (Model, Cmd Msg)
-- init : Url -> (Model, Cmd Msg)
init maybeViewer url navKey =
    Debug.log("Maain.elm init")
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
                Debug.log("cRt -> J R Home from Just Route.Home")
                Home.init session
                    |> updateWith Home GotHomeMsg model
            Just Route.Admin ->
                Admin.init session
                    |> updateWith Admin GotAdminMsg model
            Just Route.Login ->
                Debug.log("cRt -> J R Login from Just Route.Login")
                Login.init session
                    |> updateWith Login GotLoginMsg model
            Just Route.Register ->
                Register.init session
                    |> updateWith Register GotRegisterMsg model
                -- Register.init session (Register model)
            Just Route.NewArticle ->
                Editor.initNew session
                    |> updateWith Editor GotEditorMsg model


updateWith : (subModel -> Model) -> (subMsg -> Msg) -> Model -> (subModel, Cmd subMsg) -> (Model, Cmd Msg)
updateWith toModel toMsg model(subModel, subCmd) =
    Debug.log("updateWith")
    ( toModel subModel
    , Cmd.map toMsg subCmd
    )


toSession : Model -> Session
toSession page =
    case page of
        Redirect session ->
            Debug.log("M.e toSession -> Redirect session")
            session
        Home home ->
            Debug.log("M.elm -> toSession Home")
            Home.toSession home
        NotFound session ->
            session
        Admin admin ->
            Debug.log("M.elm -> toSession Admin")
            Admin.toSession admin
        Login login ->
            Debug.log("M.elm -> toSession Login")
            Login.toSession login
        Register register ->
            Register.toSession register
        Editor editor ->
            Editor.toSession editor

type Msg
    = GotHomeMsg Home.Msg
    | GotAdminMsg Admin.Msg
    | GotLoginMsg Login.Msg
    | GotRegisterMsg Register.Msg
    | GotEditorMsg Editor.Msg
    | ClickedLink Browser.UrlRequest
    | ChangedUrl Url
    | Ignored



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case (msg, model) of
        (GotHomeMsg subMsg, Home home) ->
            Home.update subMsg home
                 |> updateWith Home GotHomeMsg model
        (GotAdminMsg subMsg, Admin admin) ->
            Admin.update subMsg admin
                 |> updateWith Admin GotAdminMsg model
        (GotLoginMsg subMsg, Login login) ->
            Debug.log("M.e -> update -> GotLoginMsg")
            Login.update subMsg login
                |> updateWith Login GotLoginMsg model

        -- (GotRegisterMsg EnteredEmail email, Register registerModel) ->
                   -- Register.update EnteredEmail registerModel
                   -- |> updateWith Register GotRegisterMsg model
                   -- expect --
                   -- (Register.update GotRegisterMsg EnteredEmail email,
                   -- model registerModel, Cmd.batch[])
                   -- Cmd ... Register update cmds, register decides


        (GotRegisterMsg subMsg, Register register) ->
            Register.update subMsg register
                |> updateWith Register GotRegisterMsg model
        (GotEditorMsg subMsg, Editor editor) ->
            Editor.update subMsg editor
                |> updateWith Editor GotEditorMsg model
        (ClickedLink urlRequest, _)  ->
            case urlRequest of
                Browser.Internal url ->
                    Debug.log("M.e -> ClickdLnk Internal")
                    (model,
                         Nav.pushUrl (Session.navKey (toSession model)) (Url.toString url))
                Browser.External url ->
                    (model,
                         Nav.load url)
        (ChangedUrl url, _ ) ->
            Debug.log("M.e -> changed Url")
            changeRouteTo (Route.fromUrl url) model
        (Ignored, _) ->
            Debug.log("M.e -> Ignored")
            (model, Cmd.none)
        (_,_) ->
            Debug.log("M -> _,_")
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
            viewPage Page.Admin GotAdminMsg (Admin.view admin)
        Login login ->
            Debug.log("M.e -> view -> Login login")
            viewPage Page.Login GotLoginMsg (Login.view login)
        Register register ->
            viewPage Page.Register GotRegisterMsg (Register.view register)
        Editor editor ->
            viewPage Page.Other GotEditorMsg (Editor.view editor)
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
