module Scratchpads where

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Queue
import Signal exposing ((<~))
  
import StartApp

port scratchpadURL : Signal (Maybe String)

maybeMap f m = case m of
                 Nothing -> Nothing
                 Just v -> Just (f v)

main = let actionS = Signal.mailbox Nothing
           address = Signal.forwardTo actionS.address Just
           inputSignal = Signal.mergeMany [
                          actionS.signal,
                          (maybeMap SetURL)  <~ scratchpadURL
                         ]
           modelS = Signal.foldp
                      (\ (Just action) model -> update action model)
                      BlankModel
                      inputSignal
       in Signal.map (view address) modelS

type Model = BlankModel
           | FetchingModel String {- URL -}
           | ScratchpadModel {
               url: String,
               pad: Scratchpad,
               pushesPending: Queue.Queue Push,
               inaccurateFields: List FieldIndex,
               syncingFields: List FieldIndex
             }

newPadModel : String -> Scratchpad -> Model
newPadModel url p = ScratchpadModel {
                  url = url,
                  pad = p,
                  pushesPending = Queue.empty,
                  inaccurateFields = [],
                  syncingFields = []
                }

type Action = Stuff
            | SetURL String

type Scratchpad = Pad {
    name: String,
    author: {id: Integer, name: String},
    id: Integer,
    description: String
  }

type Push = Push

type FieldIndex = Idx
                                
view address model = div [] [text (toString model)]

update action model =
  case model of
    BlankModel -> case action of
                    Stuff -> BlankModel
                    SetURL url -> FetchingModel url
