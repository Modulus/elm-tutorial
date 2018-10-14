module SocketToMe exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onSubmit, onInput)
import WebSocket

-- Model
type alias Model =
    { input : String
    , messages : List String
    }


init : (Model, Cmd Msg)
init =
    (Model "" ["test test"], Cmd.none)

socketUrl : String
socketUrl =
    "ws://localhost:8080/connect"
    --"ws://echo.websocket.org"

-- Update
type Msg
    = Input String
    | SendToSocket
    | NewMessageReceived String

-- Update
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Input str ->
            ({ model | input = str}, Cmd.none)
        SendToSocket ->
            ( model, WebSocket.send socketUrl model.input )
        NewMessageReceived str ->
            ( {model | input = "", messages =  str :: model.messages }, Cmd.none)

 -- Subscriptions
subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen socketUrl NewMessageReceived


-- View
view: Model -> Html Msg
view model =
    div []
    [ ul [] (List.reverse (List.map(\i -> li [] [text i ] ) model.messages ) )
      , input [ onInput Input ] [ ]
      , button [onClick SendToSocket ][ text "Send"]
    ]

main =
    Html.program { init = init
                    , view = view
                    , subscriptions = subscriptions
                    , update = update
                    }