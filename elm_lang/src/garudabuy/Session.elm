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
            Debug.log("v -> Li")
            Just val
        Guest _ ->
            Debug.log("v -> G")
            Nothing

cred : Session -> Maybe Cred
cred session =
    case session of
        LoggedIn _ val ->
            Debug.log("Sess.e cred -> Li")
            Just (Viewer.cred val)
        Guest _ ->
            Debug.log("Sess.e cred -> G")
            Nothing


fromViewer : Nav.Key -> Maybe Viewer -> Session
fromViewer key maybeViewer =
    case maybeViewer of
    Just viewerVal ->
        Debug.log("Sess.e fromViewer -> LI")
        LoggedIn key viewerVal
    Nothing ->
        Debug.log("Sess.e fromViewer -> G")
        Guest key


navKey : Session -> Nav.Key
navKey session =
    case session of
        LoggedIn key _ ->
            Debug.log("Sess -> nK LI")
            key
        Guest key ->
            Debug.log("Sess -> nK G")
            key
