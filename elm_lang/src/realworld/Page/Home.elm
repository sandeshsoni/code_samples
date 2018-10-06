module Home exposing (..)
import Html exposing (..)

-- Model
type Status a
    = Loading
    | Loaded a




-- View

view : Model -> { title: String, content: Html Msg }
view model =
    { title: "Our Homepage"
    , content:
        div [] [ text "lorel ipsum"]
    }



type Msg
    = ClickViewProfile
    | ClickTag
