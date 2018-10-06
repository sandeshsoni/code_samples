module Home exposing (..)
import Html exposing (..)
import Session exposing (Session)

-- Model
type Status a
    = Loading
    | Loaded a


type alias Model =
    { session : Session
    , timeZone : Time.Zone
    }

-- View

view : Model -> { title: String, content: Html Msg }
view model =
    { title = "Our Homepage"
    , content =
        div [] [ text "lorel ipsum"]
    }



type Msg
    = ClickViewProfile
    | ClickTag
