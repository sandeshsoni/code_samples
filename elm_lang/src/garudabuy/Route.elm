module Garudabuy.Route exposing (..)

import Url exposing (Url)
import Browser.Navigation as Nav
import Url.Parser as Parser exposing ((</>), Parser, oneOf, s, string)



type Route
    = Home
    | Admin

parser : Parser (Route -> a) a
parser =
    oneOf
        [ Parser.map Home Parser.top
        , Parser.map Admin (s "admin")
        ]

-- match and get top most
fromUrl : Url -> Maybe Route
fromUrl url =
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
        |> Parser.parse parser




