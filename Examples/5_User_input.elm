module UserInput exposing (Model, Msg(..), adjustSize, main, myModel, myUpdate, myView)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main =
    Html.beginnerProgram { model = myModel, view = myView, update = myUpdate }


type alias Model =
    { text : String }


myModel : Model
myModel =
    { text = "" }


type Msg
    = Text String



-- Update stuffs


myUpdate : Msg -> Model -> Model
myUpdate msg model =
    case msg of
        Text updatedText ->
            { model | text = updatedText }



-- Replaced by adjustSize
--smallText : Attribute msg
--smallText =
--    style [
--        ("fontSize", "8em"),
--        ("color", "red")
--    ]
--bigText : Attribute msg
--bigText =
--    style [
--        ("fontSize", "20em"),
--        ("color", "sandybrown")
--    ]
--
--
--checkTextSize : String -> Attribute msg
--checkTextSize str =
--    if String.length str < 8 then
--        bigText
--    else
--        smallText


adjustSize : Model -> Attribute msg
adjustSize { text } =
    let
        ( size, color ) =
            if String.length text < 8 then
                ( "20em", "goldenrod" )

            else
                ( "10em", "seashell" )
    in
    style
        [ ( "fontSize", size )
        , ( "color", color )
        , ( "fontFace", "Verdana" )
        ]



-- view


myView : Model -> Html Msg
myView model =
    div []
        [ input [ placeholder "Type text here", onInput Text ] []
        , div [ adjustSize model ] [ text model.text ]
        ]
