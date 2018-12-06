module Garudabuy.Route exposing (..)

import Url exposing (Url)
import Browser.Navigation as Nav
import Url.Parser as Parser exposing ((</>), Parser, oneOf, s, string)
import Html.Attributes as Attr
import Html exposing (Attribute)


type Route
    = Home
    | Admin
    | Login
    | Register
    | NewArticle

parser : Parser (Route -> a) a
parser =
    oneOf
        [ Parser.map Home Parser.top
        , Parser.map Admin (s "admin")
        , Parser.map Login (s "login")
        , Parser.map Register (s "register")
        , Parser.map NewArticle (s "editor")
        ]

-- match and get top most
fromUrl : Url -> Maybe Route
fromUrl url =
    Debug.log("Route.e -> fromUrl")
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
        |> Parser.parse parser


href : Route -> Attribute msg
href targetRoute =
    Attr.href (routeToString targetRoute)

routeToString : Route -> String
routeToString page =
    let
        pieces =
            case page of
                Home ->
                    []
                Admin ->
                    ["admin"]
                Login ->
                    ["login"]
                Register ->
                    ["register"]
                NewArticle ->
                    ["editor"]

    in
        "#/" ++ String.join "/" pieces


replaceUrl : Nav.Key -> Route -> Cmd msg
replaceUrl key route =
    Nav.replaceUrl key (routeToString route)

