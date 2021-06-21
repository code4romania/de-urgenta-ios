# De urgenta - iOS app

[![GitHub contributors](https://img.shields.io/github/contributors/code4romania/de-urgenta-ios.svg?style=for-the-badge)](https://github.com/code4romania/de-urgenta-ios/graphs/contributors) [![GitHub last commit](https://img.shields.io/github/last-commit/code4romania/de-urgenta-ios.svg?style=for-the-badge)](https://github.com/code4romania/de-urgenta-ios/commits/master) [![License: MPL 2.0](https://img.shields.io/badge/license-MPL%202.0-brightgreen.svg?style=for-the-badge)](https://opensource.org/licenses/MPL-2.0)

**Check out the [Wiki](https://github.com/code4romania/de-urgenta-backend/wiki)!**

De Urgență [was prototyped](https://civiclabs.ro/ro/solutions/stay-together) in [Code for Romania](https://code4.ro/ro)'s research project, [Civic Labs](https://civiclabs.ro/ro).

The application aims to inform citizens about how to react to the first critical hours in a crysis situation (like that of an earthquake). 

It also aims to build healthy habits that become ingrained with time, so that, when the critical moment arrives, each person knows what the key first steps to keeping themselves safe are. 

[See the project live](insert_link_here)

[Contributing](#contributing) | [Repos and projects](#repos-and-projects) | [Deployment](#deployment) | [Feedback](#feedback) | [License](#license) | [About Code4Ro](#about-code4ro)

## Contributing

This project is built by amazing volunteers and you can be one of them! Here's a list of ways in [which you can contribute to this project](https://github.com/code4romania/.github/blob/master/CONTRIBUTING.md). If you want to make any change to this repository, please **make a fork first**.

Help us out by testing this project in the [staging environment](INSERT_LINK_HERE). If you see something that doesn't quite work the way you expect it to, open an Issue. Make sure to describe what you _expect to happen_ and _what is actually happening_ in detail.

If you would like to suggest new functionality, open an Issue and mark it as a __[Feature request]__. Please be specific about why you think this functionality will be of use. If you can, please include some visual description of what you would like the UI to look like, if you are suggesting new UI elements. 

### Programming languages

Swift

### Platforms

iOS 10.0+

### Package managers

Cocoapods

### Database technology & provider

Core Data with sqlite

### API endpoints

[Swagger](https://api.deurgenta.hostmysite.ro/swagger/index.html)

## Repos and projects

[Android repo](https://github.com/code4romania/de-urgenta-android)   
[iOS repo](https://github.com/code4romania/de-urgenta-ios)   
[Web app - frontend](https://github.com/code4romania/de-urgenta-client)   
[Web app - backend](https://github.com/code4romania/de-urgenta-backend)

## Before Starting

This project uses swift and has dependencies on Firebase and HERE Maps. This means before starting work on the actual code, you will have to create apps on these two platforms and use their API credentials locally. 

### Firebase

Go to the [Firebase Console](https://console.firebase.google.com) for your Google account and create an app named "De Urgenta". Go through the steps and download the `GoogleService-Info.plist` file and copy it in the root of the local clone of this repo.

### HERE Maps

Go to the [HERE developer portal](https://developer.here.com), create an account if you don't have one, and create an app named "De Urgenta". Find the iOS SDK (premium) section and note those api credentials.

Into the cloned repo, navigate to `DeUrgenta/Config/Custom`. You fill find a `Config.xcconfig` file with some default properties. Duplicate it and rename the new file to `LocalConfig.xcconfig` (and remove the `#include` line at the end). Use this xcconfig to set the api credentials for the here maps.

### Other Local Config Options

Into the same `LocalConfig.xcconfig` file, set the app id and team id to values appropriate to your Apple Developer account, you will need these, to deploy on devices.

### Pods

Run `pod install` in the repo folder and you should be good to go.

### Questions?

If you ran into trouble on any of these issues, you can get in touch with us on the Code4Romania Slack.

## Code Conventions

We use the following code conventions, and if anything is unclear, please take a look at the existing code for examples of how they're implemented.

1. MvvM - Each ViewController has its ViewModel (unless the VC is very trivial and has not much logic inside it)
2. Parent VCs inherit from `DUViewController` (so that in the future we can add extra functionality to all parent VCs)
3. Use Nibs for UI compositionm only do it in code when it makes sense or the component is highly customizable
4. Use children VCs as much as possible to prevent MVC (massive view controllers)
5. Use custom UIViews for reusable components instead of duplicating views 
6. DULabel, DUButton etc. - IBDesignables that make it easy to add font-abstraction to Nibs, use them instead of configuring the font independently
7. Use color presets and image presets (and add to those as necessary).
8. Use asset catalogs for resources.
9. Use PDFs for vector images exported from figma, PNGs for bitmaps and JPEGs for complex photos (like avatars)
10. Use `Promises` whenever possible for async code (it's OK to use blocks when the situation calls for it, but ideally convert 3rd party callbacks to promises to keep our code clean).
11. Use Managers for highly specific and possibly reusable code (see the `Managers` group for examples). Make them singletons if there's no need for multiple instances.
12. Use the xcconfig files to add locally configurable variables instead of hardcoding them (add the variable in `Config.xcconfig`, then add it with the same name in the `Info.plist` and value `$(VAR_NAME)`, then add the case into `Config.swift`.
13. No `print` statements. If you want to print debug without a breakpoint, use the `LogDebug`, `LogInfo` and `LogError` functions.
14. Use `AppRouter` for navigation.
15. To minimize PR conflicts, please merge `develop` into your branch before pushing the PR.

We will add to these rules as the project develops. If you have anything against these, we can have a discussion over Slack, but ideally they will have to do, to keep us all working on this project happy.

## Feedback

* Request a new feature on GitHub.
* Vote for popular feature requests.
* File a bug in GitHub Issues.
* Email us with other feedback contact@code4.ro

## License

This project is licensed under the MPL 2.0 License - see the [LICENSE](LICENSE) file for details

## About Code for Romania

Started in 2016, Code for Romania is a civic tech NGO, official member of the Code for All network. We have a community of around 2.000 volunteers (developers, ux/ui, communications, data scientists, graphic designers, devops, it security and more) who work pro-bono for developing digital solutions to solve social problems. #techforsocialgood. If you want to learn more details about our projects [visit our site](https://www.code4.ro/en/) or if you want to talk to one of our staff members, please e-mail us at contact@code4.ro.

Last, but not least, we rely on donations to ensure the infrastructure, logistics and management of our community that is widely spread across 11 timezones, coding for social change to make Romania and the world a better place. If you want to support us, [you can do it here](https://code4.ro/en/donate/).
