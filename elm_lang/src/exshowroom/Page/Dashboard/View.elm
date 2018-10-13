module Page.Dashboard.View exposing (View)

import Html exposing (..)

import Page.Dashboard.Model exposing (Model)

view : Model -> Html Msg
view model =
    div []
        [ h2 [][ text model.currentUser ]
        , div [][ text model.pageBody ]
        ]


-- Multi tabs
-- Users tab
-- Organisations tab
-- Products tab
-- Add new product tab
