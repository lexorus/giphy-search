## Giphy Search
Small two screen application which allows you to search through the GIFs from Giphy and view them. It also displays a random GIF every 10 seconds if you don't enter any query.

## Contents

1. [Overview](#overview)
2. [Project infrastructure](#project-infrastructure)
3. [API layer](#api-layer)
4. [Presentation layer](#presentation-layer)
5. [Application layer](#application-layer)
6. [Tests](#tests)
7. [How to test](#how-to-test)
8. [Things left to do](#things-left-to-do)

## Overview
The main idea behind the implementation of this project is that I wanted to learn/try some new ideas, so don't expect the best code quality or test coverage.
The concepts that were used as the foundation for this project are:

1. Modularization

    The code is separated into different frameworks, based on the responsibilities it has. There are three targets: api, ui and application.

2. Horizontal dependency graph

    Instead of having our UI module depending on API module, since the UI will need to use the functions/models provided by API, they depend on declared interfaces. This dependency inversion allows us to have this `App -> API, APP -> UI` instead of `App -> UI -> API`. Besides the separation of concerns, in a larger app we will have an increased build time as a bonus.

3. Playground driven development

    Most of the code, including UI, was developed without launching the application. In each target you will find Playground pages, that were used to run the code. The UI code is working with mocked data, without doing any actual requests to the API. Note: to be able to actually run and see the results you need first to build the framework.

4. Extensive usage of Container View Controllers

    There are many ways to separate the responsibilities of your view controller. Besides using MVP architectural pattern, I decided to separate the logic into small reusable view controllers. We have 5 view controllers in this two-screen app. For more detailed description please check [Presentation Layer](#presentation-layer) section.


## Project infrastructure
As mentioned in [Overview](#overview) section, the project has three main targets: `GifAPI`, `GiphySearchUI` and `GiphySearchChallenge`. Each of these can be developed and tested independently. Usually, I would use a dependency management system, like cocoapods, to track the dependency versions and be able to lock to a specific version, but this would be an overkill for this project. Maybe this will be added at some point.

## API layer
The `GifAPI` is a public interface that describes the promises of the API. The `GiphyAPI` is a concrete implementation of those promises. Usually, in case of a more complex API layer, I would build a more complex hierarchy, separating all the requests into models.

## Presentation layer
The presentation logic is separated among the 5 modules:
1. `GifPlayer` - This view controller is responsible for repeated play of the GIF. It also shows the GIF title and link under the player.
2. `GifDetails` - This view controller is used for presenting the details of the GIF, when it is selected from the results. The main responsibilities are to set up the navigation bar and the child `GifPlayer` controller.
3. `RandomGif` - This view controller is responsible for fetching the random GIF every 10 seconds and display it using child `GifPlayer` controller. It also can handle fetching failure.
4. `GifSearchResults` - The main responsibility of this view controller is to manage the collection view with results. The states it can handle right now are described in `GifSearchResultsState`. For now, it only has `Initial` stage, and should be extended with `Iterative` once the pagination will be added. An example of this can be found [here](https://github.com/lexorus/flickr-search/blob/master/FlickrSearch/Modules/Search/ViewController/SearchViewControllerEventState.swift). This controller also can handle error states. The search query is supplied using the observer pattern and `GifSearchQueryProvider`.
5. `GifSearch` - This is the first screen of the app. It has two child controllers: `RandomGif` and `GifSearchResults`. The main responsibility of this is to manage the `SearchBar` and keyboard appearance. It also injects the necessary dependencies into the child view controllers.

This approach helps us to keep the responsibilities of the controllers atomic, having small reusable modules that are easy to understand and read.

## Application layer
Since I moved all the `API` and `UI` logic away from the main application target, the only responsibilities left are:
1. Define the flow of the application - `GifSearchFlow`.
2. Mediate the communication between the `API` and `UI` layers. This is mostly done through abstractions and mapping.

I would invest some more time into this layer since I'm not really happy with the way it looks right now, but this will really depend on the further development and decisions. Usually, the best architecture decision is taken as late as possible.

## Tests
There are test targets for each of the layer, which contain a set of tests. Those were added mostly as examples and proof that the code that is written is easily testable. For production app, I would really invest more time into writing tests, and not only unit tests. You can also check the tests in the projects that are linked in this document earlier.

## How to test

By default, the `OfflineFakeGifRepository` is used as the API mock. The fake repository will mimic the behaviour of the real one, but will operate will only two mocked GIFs. If you want to use the project against the real Giphy API, you need to specify your API key instead of `your_giphy_api_token` and uncomment the necessary line in `GifSearchFlow.swift:10`.

`Simulator:` You should be able to just run the application on the simulator with no problems.

`Device:` To run the application on a device you will need to specify the "Development Team" in "Singing & Capabilities" and may be required to change the "Bundle Identifier" in the same tab.

## Things left to do
1. Pagination for search results

    It shouldn't be hard to add since all the setup is done. We will need just a paginator that will keep track of the pages, and a new possible stage to the UI configuration. An example of this can be found [here](https://github.com/lexorus/flickr-search/blob/0643e65b6c329d2dac885d753c39cef398c31f60/FlickrSearch/Modules/Search/ViewModel/Services/Paginator.swift).

2. Tests coverage

    This project requires more tests. Everything is written to be testable, so it's just time that needs to be invested.

3. Adjust caching

    There is some caching implemented in `GiphyRepository`, but it's only in-memory, and not implemented in the best way. 

4. Debouncer for search
5. A nice icon and launch screen :)
