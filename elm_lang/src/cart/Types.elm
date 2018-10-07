module Cart.Types exposing (..)

type alias Product =
    { id : String
    , name : String
    , category : String
    , price : Float
    , isInStock : Bool
    , pictureURL : Maybe String
    , description : String
    }

type alias SubCategory =
    { id : String
    , name : String
    }

type alias Category =
    { id: String
    , name : String
    , description: String
    , subCategories : List SubCategory
    }

type alias Item =
    { product : Product
    , quantity : Int
    }


type alias Cart =
    { items : List Item}


type Page
    = ProductList
    | ProductDetail
    -- | Checkout


type alias Model =
    { cart : Cart
    , availableProducts : List Product
    , availableCategories : List Category
    , page : Page
    , currentProduct : Maybe Product
    }


type Msg
    = AddToCart Product

