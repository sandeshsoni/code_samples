module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class)

-- main : Html msg
-- main =
--     text "hola bulkdrop"

type alias Model =
    { content : String }

init : Model
init =
    { content = "" }

-- UPDATE
type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }

view model =
    div []
        [ header
        , container
        , footer
        ]

header =
    div [ class "header" ] [ h1[][ text "BulkDrop!"]  ]

container =
    div [ class "container" ][ text "Welcome!" ]

footer =
    div [ class "footer "] [ text "footer" ]


main =
    Browser.sandbox { init = init, update = update, view = view }
