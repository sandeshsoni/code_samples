module Garudabuy.Session exposing (..)

import Garudabuy.Api exposing (Cred)
import Browser.Navigation as Nav
import Garudabuy.Viewer as Viewer exposing (Viewer)


type Session
    = LoggedIn Nav.Key Viewer
    | Guest Nav.Key


viewer : Session -> Maybe Viewer
viewer session =
    case session of
        LoggedIn _ val ->
            Just val
        Guest _ ->
            Nothing

cred : Session -> Maybe Cred
cred session =
    case session of
        LoggedIn _ val ->
            Just (Viewer.cred val)
        Guest _ ->
            Nothing


fromViewer : Nav.Key -> Maybe Viewer -> Session
fromViewer key maybeViewer =
    case maybeViewer of
    Just viewerVal ->
        LoggedIn key viewerVal
    Nothing ->
        Guest key


navKey : Session -> Nav.Key
navKey session =
    case session of
        LoggedIn key _ ->
            key
        Guest key ->
            key
