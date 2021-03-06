module Garudabuy.Page exposing (..)

import Garudabuy.Viewer as Viewer exposing (..)
import Garudabuy.Route as Route exposing (..)

import Browser exposing (Document)
import Html exposing (Html, li, p, div, a, text)

type Page
    = Home
    | Admin
    | Login
    | Register
    | Other

view : Maybe Viewer -> Page -> {title: String, content: Html msg} -> Document msg
view maybeViewer page {title, content} =
    Debug.log("Page.e view")
    { title = title ++ " | Company name"
    , body = viewMenu page maybeViewer ++ [content]
    }


-- header
-- viewHeader: Page ->

-- side menu
viewMenu : Page -> Maybe Viewer -> List (Html msg)
viewMenu page maybeViewer =
    let linkTo =
            navbarLink page
    in
    case maybeViewer of
        Just viewer ->
            let
                username =
                    "abc"
                    -- Viewer.username viewer
            in
                [ linkTo Route.Admin [ text "newPost " ]]

        Nothing ->
            [ linkTo Route.Admin [ text "Admin" ]
            , linkTo Route.Home [ text "Home" ]
            , linkTo Route.Login [ text "Log In" ]
            , linkTo Route.Register [ text "Register" ]
            , linkTo Route.NewArticle [ text "New Article" ]
            ]

navbarLink : Page -> Route -> List(Html msg) -> Html msg
navbarLink page route linkContent =
    li [][a[Route.href route] linkContent ]



-- links to other pages
