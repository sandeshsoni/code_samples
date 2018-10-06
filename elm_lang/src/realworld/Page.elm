module RealWorld.Page exposing (..)

type Page
    = Other
    | Home
    | Login



viewHeader : Html msg
viewHeader
    = div [][ text "some header." ]

viewFooter : Html msg
viewFooter
    = footer []
      [ div [ class "container" ]
            [ text "footer, &copy, year" ]
      ]


-- Msg
-- possible Events

-- Update
