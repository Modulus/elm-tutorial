module MouseClicker exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Char
import Html exposing (Html, div, program, text)
import Keyboard
import Mouse


main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { x : Int
    , y : Int
    , keyPressed : Int
    }



-- INIT


init : ( Model, Cmd Msg )
init =
    ( Model 0 0 0, Cmd.none )



-- Messages


type Msg
    = MouseMessage Mouse.Position
    | KeyboardMessage Keyboard.KeyCode



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseMessage position ->
            ( { model | x = position.x, y = position.y }, Cmd.none )

        KeyboardMessage code ->
            ( { model | keyPressed = code }, Cmd.none )



-- SUBSCRIPTION


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Mouse.clicks MouseMessage
        , Keyboard.presses KeyboardMessage
        ]



-- View


view : Model -> Html Msg
view model =
    div []
        [ text
            ("Postion x is: "
                ++ toString model.x
                ++ " and y is: "
                ++ toString model.y
            )
        , div []
            [ text ("You pressed: " ++ toString (Char.fromCode model.keyPressed)) ]
        ]
