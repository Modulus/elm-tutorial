module HelloTwo exposing (main)

import Html exposing (..)
import Html.Attributes exposing (class)


main : Html msg
main =
    div [ class "elm-div" ]
        [ h1 [ class "banner" ] [ text "Welcome to my elm site :D ye dirty ol bastard!" ]
        , p [] [ text "I am liking Elm so far!" ]
        , p [] [ text "Eager to learn more about elm" ]
        ]
