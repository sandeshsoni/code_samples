module Route exposing(Route)
import Url.Parser as Parser exposing ((</>), Parser, oneOf, s, string)

import Vehicle.Slug as VehicleSlug exposing (Slug)

-- ROUTING --

type Route
    = Home
    | About
    | UpcomingCars
    | Vehicle


-- When need parameters on form base/item/id
-- | Item String
-- | Vehicle CarModel Variation

routeMatcher : Parser (Route -> a) a
routeMatcher =
    oneOf
        [ Parser.map Home (s "")
        , Parser.map About (s "about")
        , Parser.map Vehicle (s "cars" </> VehicleSlug.urlParser)
        ]


