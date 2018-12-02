module Garudabuy.Page exposing (..)

import Garudabuy.Viewer as Viewer exposing (..)

import Browser exposing (Document)
import Html exposing (Html)

type Page
    = Home
    | Admin
    | Other

view : Maybe Viewer -> Page -> {title: String, content: Html msg} -> Document msg
view maybeViewer page {title, content} =
    { title = title ++ " | Company name"
    , body = [content]
    }


-- header

-- side menu

-- links to other pages
