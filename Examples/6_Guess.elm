module Guess exposing (Model, Msg(..), main, model, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main =
    Html.beginnerProgram { model = model, view = view, update = update }


type alias RevealedWord =
    { position : Int, text : String }


type alias Result =
    { text : String, isCorrect : Bool }


type alias Model =
    { word : String
    , guess : String
    , revealedWord : RevealedWord
    , result : Result
    , wordList : List String
    }


initialWordList : List String
initialWordList =
    [ "Banana", "Kitten", "Paperclip", "Orangutan", "Italic", "Afternoon", "Saturday" ]


model : Model
model =
    Model "Saturday" "" { position = 2, text = "S" } { text = "", isCorrect = False } initialWordList


type Msg
    = Answer String
    | Reveal
    | Check
    | Another


update : Msg -> Model -> Model
update msg model =
    case msg of
        Answer inputText ->
            { model | guess = inputText }

        Reveal ->
            { model | revealedWord = revealAndIncrement model }

        Check ->
            { model | result = checkResult model }

        Another ->
            let
                newWord =
                    getNewWord model
            in
            { model
                | word = newWord
                , guess = ""
                , revealedWord = { position = 2, text = String.slice 0 1 newWord }
                , wordList = List.drop 1 model.wordList
            }


revealAndIncrement : Model -> { position : Int, text : String }
revealAndIncrement { revealedWord, word } =
    if revealedWord.text == word then
        revealedWord

    else
        { revealedWord | position = revealedWord.position + 1, text = String.slice 0 revealedWord.position word }


getNewWord : Model -> String
getNewWord { wordList, word } =
    wordList
        |> List.filter (\a -> a /= word)
        |> List.take 1
        |> String.concat


checkResult : Model -> Result
checkResult { word, guess, result } =
    if String.toLower word == String.toLower guess then
        { result | text = "You got it", isCorrect = True }

    else
        { result | text = "Nope", isCorrect = False }


genResult : Model -> Html Msg
genResult { result } =
    if String.isEmpty result.text then
        div [] []

    else
        let
            color =
                if result.isCorrect then
                    "forestgreen"

                else
                    "tomato"
        in
        div
            [ style
                [ ( "color", color )
                , ( "fontSize", "5em" )
                , ( "fontFamily", "impact" )
                ]
            ]
            [ text result.text ]


mainStyle : Attribute msg
mainStyle =
    style
        [ ( "textAlign", "center" )
        , ( "fontSize", "2em" )
        , ( "fontFamily", "monospace" )
        ]


view : Model -> Html Msg
view model =
    div [ mainStyle ]
        [ h2 []
            [ text
                ("I'm thinking of a word that starts with"
                    ++ toString model.revealedWord.text
                    ++ " that has "
                    ++ toString (String.length model.word)
                    ++ " letters."
                )
            ]
        , input [ placeholder "Type your guess", onInput Answer ] []
        , p []
            [ button [ onClick Reveal ] [ text "Hint" ]
            , button [ onClick Check ] [ text "Submit Answer" ]
            , button [ onClick Another ] [ text "Another word" ]
            ]
        , genResult model
        ]



--revealLetter : Model -> String
--revealLetter model =
--    if String.length model.word == String.length model.revealedWord then
--        model.word
--    else
--        String.slice 0 model.revealedPosition model.word
{--checkIfCorrect : Model -> String -> Bool
checkIfCorrect model inputText =
    if inputText == model.word then
        True

    else
        False
--}
{--generateResult : Model -> Html Msg
generateResult { isCorrect, revealedWord, word } =
    let
        txt =
            if revealedWord.text == word then
                "You didn't get it"

            else if isCorrect then
                "You got it"

            else
                "Nope"
    in
        text txt
--}
