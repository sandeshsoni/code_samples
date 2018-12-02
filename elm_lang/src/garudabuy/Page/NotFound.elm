module Garudabuy.Page.NotFound exposing (..)
import Html exposing (Html, h1, text, main_)
import Html.Attributes exposing (id, class)

view : { title: String, content: Html msg }
view =
    { title = "Page not Found"
    , content =
          main_ [ id "content", class "container"]
             [ h1 [][text "Not Found" ]
             ]
    }
