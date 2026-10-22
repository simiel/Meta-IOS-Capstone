# Little Lemon

Little Lemon is a SwiftUI iOS app for browsing a restaurant menu, written by Samuel Mensa ([@simiel](https://github.com/simiel)) as a Meta iOS capstone. A guest enters a first name, last name, and email on a local login screen, then uses a tabbed home to search the menu and open a dish, or to view and clear that saved profile. The menu is the public Little Lemon dataset from Meta’s mobile-developer coursework. The build in this repository presents the restaurant as Little Lemon, East Legon Hills.

![Little Lemon menu with search and dish rows](<Screenshot 2024-08-22 at 10.13.12 PM.png>)

## Features

- **Local login.** Onboarding collects first name, last name, and email and stores them in `UserDefaults`. All three fields are required. On a later launch, a guest who already has those values skips the form and lands on the home screen.
- **Tabbed home.** After login, a `TabView` shows Menu and Profile.
- **Menu from the network, stored on device.** When the Menu tab appears, the app requests the course menu JSON, decodes each item’s title, description, price, image URL, and category, batch-deletes the existing `Dish` rows, and saves the new rows in Core Data.
- **Search and dish detail.** Dishes are listed in title order with price and a remote image. The search field filters titles on device. A row opens a detail screen with the description, price, and image.
- **Profile and logout.** Profile shows the saved name and email beside a bundled photo. Logout clears the saved fields and returns to the login screen.

## Tech stack

- Swift 5 and SwiftUI
- Core Data (`NSPersistentContainer`, `NSBatchDeleteRequest`, `@FetchRequest`)
- `URLSession` and `JSONDecoder`
- `UserDefaults` for the profile
- `AsyncImage` for dish photos
- XCTest unit and UI test targets
- Xcode project, iOS deployment target 17.4, marketing version 1.0
- Apple frameworks only: no CocoaPods, Swift Package Manager, or other third-party dependencies

## Architecture

One app target and two test targets. Screens live under `Views`, the JSON models under `Models`, and the Core Data stack in `Persistence.swift`. The app entry injects the view context into the SwiftUI environment.

```
Meta-IOS-Capstone/
  Meta_IOS_CapstoneApp.swift       App entry; injects the Core Data view context
  ContentView.swift                Shows onboarding or home from the saved profile
  Persistence.swift                Shared stack, in-memory preview store, batch clear
  FetchedObjects.swift             Generic SwiftUI wrapper around FetchRequest
  Models/Menu.swift                MenuList and MenuItem (Decodable, Hashable)
  Views/
    OnboardingView.swift           Login form
    HomeView.swift                 Menu and Profile tabs
    MenuView.swift                 Fetch, persist, search, and list
    DishDetailView.swift           Title, description, price, image
    UserView.swift                 Profile and logout
  Meta_IOS_Capstone.xcdatamodeld   Core Data model; the menu uses the Dish entity
  Assets.xcassets                  Profile image, accent color, app icon
Dish+CoreDataClass.swift           Dish subclass, compiled from the repo root
Dish+CoreDataProperties.swift      title, desc, price, image, category
Meta-IOS-CapstoneTests/            Unit test target
Meta-IOS-CapstoneUITests/          UI test target, including a launch screenshot test
wireframe.png                      Screen wireframe for the restaurant flow
```

On the Menu tab, `getMenuData()` loads:

`https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json`

The response is decoded as a `MenuList`. Each `MenuItem` is written to a `Dish`. A `@FetchRequest` sorted by `title` drives the list, so the rows update from the store after the save. `PersistenceController` also builds an in-memory store for SwiftUI previews and seeds it with sample dishes. `FetchedObjects` is a generic view that takes a predicate, sort descriptors, and a content builder over the fetched objects; the menu screen reads the store with `@FetchRequest` directly.

`wireframe.png` is the interface sketch checked in with the project. The screenshot above is the menu screen the app builds: restaurant name, East Legon Hills, a short welcome line, search, and the dish list.

## Getting started

**Prerequisites**

- macOS with an Xcode that can build the iOS 17.4 SDK
- An iOS 17.4 or later simulator or device
- Network access when the Menu tab opens, so the menu JSON can download

The project has no environment variables, API keys, or secret files. The menu URL is a constant in `MenuView.swift`.

**Run**

1. Open `Meta-IOS-Capstone.xcodeproj`.
2. Select the **Meta-IOS-Capstone** scheme. The repo does not commit a shared `.xcscheme`; Xcode creates that scheme from the app target when the project is opened.
3. Choose an iPhone or iPad simulator, or a device.
4. Use Product → Run.

From a Mac with Xcode, the same target builds with:

```bash
xcodebuild -project Meta-IOS-Capstone.xcodeproj -scheme Meta-IOS-Capstone -destination 'generic/platform=iOS Simulator' build
```

**Test**

Product → Test runs the two test targets that ship with the project:

- `Meta-IOS-CapstoneTests`
- `Meta-IOS-CapstoneUITests`

```bash
xcodebuild -project Meta-IOS-Capstone.xcodeproj -scheme Meta-IOS-Capstone -destination 'platform=iOS Simulator,name=iPhone 16' test
```

Use a simulator name that exists locally (`xcrun simctl list devices`). The checked-in tests are the cases Xcode generated with the project. The UI launch test starts the app and attaches a screenshot.

## Project status

Coursework capstone, July–August 2024 (repository name `Meta-IOS-Capstone`). The app covers the Little Lemon flow from Meta’s iOS developer coursework: local login, a menu loaded from the [Working-With-Data API](https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API), Core Data storage, title search, dish details, and a profile with logout. Marketing version 1.0. The test targets are still the generated scaffolds.

## What this demonstrates

- A multi-screen SwiftUI app: an onboarding gate, a tabbed home, and a navigation push from the menu to a dish.
- A full read path from the network into the UI: `URLSession`, `Decodable` menu models, a Core Data write, and a `@FetchRequest` that refreshes the list.
- A persistence controller with a shared on-disk store, an in-memory preview container, and a batch delete before each menu refresh.
- Local session state in `UserDefaults`, including a launch check that restores a returning guest and a logout path that clears it.
- On-device title search over the persisted menu, and remote dish photos rendered with `AsyncImage`.
- An Xcode project split by role — app entry, models, views, and the Core Data model — with separate unit and UI test targets.
