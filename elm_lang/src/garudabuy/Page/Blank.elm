module Garudabuy.Page.Blank exposing (..)
import Html exposing (Html, div, text)

view : { title: String, content: Html msg}
view =
    { title = ""
    , content = div [][text "Blank"]
    }
