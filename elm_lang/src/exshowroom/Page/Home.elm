module Page.Home exposing (..)

-- export

type alias Model =
    { session : Session
    , timeZone : Time.Zone
    , feedTab : FeedTab

    --
    , tags : Status (List Tag)

    }


toSession : Model -> Session
toSession model =
    model.session
