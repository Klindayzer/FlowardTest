# Floward Shoes Show Case

This project is a small MVP to show case a techniqal task that contaisne Home screen for a movie list.

## Remarks

- Architucture used in this project is MVVM with Protocol Oreianted Programming
- All features are reseliante for provider change (network client, image cache, loader)
- All business logic is covered with 90% ~ 100% unit test
- Full depenency injection for when applicable
- Two environments running schemes (Develop, Production) 
- Clean folder organization
- All Visuals are created programmatically

## How to run

- Clone the repo
- Open Floward.xcworkspace
- Resolve SPM dependencies
- Choose the scheme and run the project

#### LevelShoes
- App Delegate: contains app and scene delegate classes
- App Modules: containe all busniess logic for application modues (home )
- Helpers: contains all configuration classes and helper extensions and environment helpers

#### AKNetworking

This is a custom networking client i've created base on URLSessions that will handle API calls

### Movies Api
I've used OMDb API to get movie list (http://www.omdbapi.com)

### Third party dependencies

I've used SPM for below dependencies
- Kingfisher for web image caching  (https://github.com/onevcat/Kingfisher)
- MBProgressHUD for adding hud loader (https://github.com/jdg/MBProgressHUD)

## Room for improvment
- Implement localization
- Add SwiftGen to automatically generate swift code representing strings, icons, custom fonts, custom colors

## Screenshots

#### Home
![Simulator Screen Shot - iPhone 13 mini - 2022-01-03 at 21 31 56](https://user-images.githubusercontent.com/39689007/147970063-857a11de-5779-4155-8412-a007c79fa6d4.png)



https://user-images.githubusercontent.com/39689007/147970267-0abdb8d9-70ae-4a3d-99c8-d5a4d15cd9f0.mp4




