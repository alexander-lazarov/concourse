module TopBar.Model exposing
    ( Dropdown(..)
    , MiddleSection(..)
    , Model
    , PipelineState(..)
    , isPaused
    )

import Concourse
import Dashboard.Group exposing (Group)
import Routes
import ScreenSize exposing (ScreenSize)


type alias Model r =
    { r
        | isUserMenuExpanded : Bool
        , isPinMenuExpanded : Bool
        , middleSection : MiddleSection
        , groups : List Group
        , screenSize : ScreenSize
        , highDensity : Bool
        , shiftDown : Bool
    }



-- The Route in middle section should always be a pipeline, build, resource, or job, but that's hard to demonstrate statically


type MiddleSection
    = Breadcrumbs Routes.Route
    | MinifiedSearch
    | SearchBar { query : String, dropdown : Dropdown }
    | Empty


type Dropdown
    = Hidden
    | Shown { selectedIdx : Maybe Int }


type PipelineState
    = None
    | HasPipeline
        { pinnedResources : List ( String, Concourse.Version )
        , pipeline : Concourse.PipelineIdentifier
        , isPaused : Bool
        }


isPaused : PipelineState -> Bool
isPaused pipeline =
    case pipeline of
        None ->
            False

        HasPipeline { isPaused } ->
            isPaused
