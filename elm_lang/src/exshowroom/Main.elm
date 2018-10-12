module Main exposing (main)

import Browser exposing (Document)

-- type Model
--     = Login Login.Model
--     | Compare Compare.Model
--     | Upcoming Latest.Model
--     | Bikes Bikes.Model
--     | Home Home.Model
--     | Register Register.Model

----- Model -----

type alias PageModel =
    { page : Page
    }

type Page
    = Home HomeModel.Model
    | About AboutModel.Model
    | Vehicle CarModel.Model

type Msg
    = GotHomeMsg Home.Msg
    | GotAboutMsg AboutMessage.Msg
    | SetRoute (Maybe Route)
    -- | GotUpcoming Latest.Msg
    -- | GotProfileMsg Profile.Msg
    -- | GotLoginMsg Login.Msg


-- view : Model -> Document Msg
-- view model =
--     let
--         viewPage page toMsg config =
--             let
--                 { title, body } =
--                     Page.view (Session.viewer (toSession model)) page config
--             in
--                 { title = title
--                 , body = List.map (Html.map toMsg) body
--                 }
--     in
--         case model of
--             Login model ->
--                 viewPage Page.Other GotLoginMsg (Login.view login)

--             Bikes bikes ->
--                 viewPage Page.Bike GotBikeMsg (Bike.view )

-- view

-- update : Msg -> Model -> (Model, Cmd Msg)
-- update msg model =
--     ( Ignored, _ ) ->
--         ( model, Cmd.none )

--     ( ClickedLink urlRequest, _ ) ->
--         case urlRequest of
--             Browser.Internal url ->
--                 case url.fragement of
--                     Nothing ->
--                         (model, Cmd.None)
--                     Just _ ->
--                         ( model
--                         , Nav.pushUrl (Session.navKey (toSession model))(Url.toString url)
--                         )


--             Browser.External href ->
--                 ( model
--                 , Nav.load href
--                 )


--                 ( ChangedUrl url, _ ) ->
--                     changeRouteTo (Route.fromUrl url) model



-- update

-- Model


-- init

