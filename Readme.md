### Articles related to this project

* [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
* [Programmatic navigation in SwiftUI project](https://nalexn.github.io/swiftui-deep-linking/?utm_source=nalexn_github)

# Clean Architecure for SwiftUI

A Rick and Morty app showcasing the setup of the SwiftUI app with Clean Architecture.

The app uses the [rickandmorty.com](https://rickandmortyapi.com) REST API tho show the list of characters and details about them.

## Key features
* Decoupled  **Presentation**, **Bussiness Logic** and **Data Access** layers
* Full test coverange including the UI (with [ViewInspector](https://github.com/nalexn/ViewInspector))
* **Redux**-like centralized `AppState` as the single source of truth
* Native SwiftUI dependency injection
* Simple yet flexible networking layer built on Generics
* Handling of the system events (such as `didBecomeActive`, `willResignActive`)
* Built with SOLID, DRY, KISS, YAGNI in mind
* Designed for scalability. It can be used as a reference for building large production apps

## Architecture overview

<p align="center">
  <img src="https://github.com/nalexn/blob_files/blob/master/images/swiftui_arc_001.png?raw=true" alt="Diagram"/>
</p>

### Presentation Layer

**SwiftUI views** that contain no business logic and are a function of the state.

Side effects are triggered by the user's actions (such as a tap on a button) or view lifecycle event `onAppear` and are forwarded to the `Interactors`.

State and business logic layer (`AppState` + `Interactors`) are natively injected into the view hierarchy with `@Environment`.

### Business Logic Layer

Business Logic Layer is represented by `Interactors`. 

Interactors receive requests to perform work, such as obtaining data from an external source or making computations, but they never return data back directly.

Instead, they forward the result to the `AppState` or to a `Binding`. The latter is used when the result of work (the data) is used locally by one View and does not belong to the `AppState`.

### Data Access Layer

Data Access Layer is represented by `Repositories`.

Repositories provide asynchronous API (`Publisher` from Combine) for making [CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete) operations on the backend or a local database. They don't contain business logic, neither do they mutate the `AppState`. Repositories are accessible and used only by the Interactors.

---
