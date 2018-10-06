module Main exposing (main)

-- import Html.App
import Browser
import Cart.State exposing (init, update, subscriptions)
import Cart.View exposing (view)

-- main : Program Never
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

