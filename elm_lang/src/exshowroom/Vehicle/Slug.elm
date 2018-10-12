module Vehicle.Slug exposing (urlParser)

import Url.Parser exposing (Parser)

--  TYPES

type Slug
    = Slug String


urlParser : Parser (Slug -> a) a
urlParser =
    Url.Parser.cutom "SLUG" (\str -> Just (Slug str))
    -- why not just Parser?

