import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- Model

type alias Model =
  {
    name : String,
    password : String,
    passwordAgain : String
  }

model : Model
model =
  Model "" "" ""

-- Update
type Msg
  = Name String
  | Password String
  | PasswordAgain String
  | Submit

update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }
    Password password ->
      { model | password = password }
    PasswordAgain passwordAgain ->
      { model | passwordAgain = passwordAgain }
    Submit ->
      model

-- View
view : Model -> Html Msg
view model =
  div []
  [ input [ type_ "text", placeholder "Enter name", onInput Name ] []
  , input [ type_ "password", placeholder "Enter password", onInput Password ] []
  , passwordValidation model
  , input [ type_ "password", placeholder "Enter password again", onInput PasswordAgain ] []
  , passwordValidation model
  , viewValidation model
  , button [ onClick Submit ] [ text "Submit" ]
  , div [] [ text model.name]
  ]

viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if model.password == model.passwordAgain then
        ("green", "OK")
      else
        ("red", "Passwords do not match!")
  in
    div [ style [("color", color)] ] [ text message ]

passwordValidation : Model -> Html Msg
passwordValidation model =
  let
    (color, message) =
      if model.password.length >= 8 then
        ("green", "Password ok")
      else
        ("red", "Password must have more than 8 characters")
  in
    div [ style [("color", color)]] [ text message]
