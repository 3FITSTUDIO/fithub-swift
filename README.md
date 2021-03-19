# Fithub

Bachelor's degree thesis at University of Gdansk, faculty of Mathematics, Physics and Information Technology.

## Getting Started

Fork this repo, run `pod install` and build the app on the desired device/simulator!

### What's used

- MVVM+Router
- Store
- Protocols
- UIKit (programatically)
- Basic HealthKit integration
- Alamofire networking
- Simple reactiveness with RxSwift to propagate data
- Basic CommonCrypto usage (password hashing)
- DIY Chart using UIKit and UIAnimation
- Unit tests (Quick / Nimble)
- Cocoapods (EasyPeasy, Alamofire, RxSwift)

### Prerequisites

- Xcode
- Cocoapods
- Macbook (to build and run the project on either a simulator device or real device)
- iPhone X, XR, XS, XS Max, iPhone 11, iPhone 11Pro, iPhone 11 Pro Max (in order to run the app on a real device)

### Installing

JSON Server
1. Install JSON Server according to the official instructions.
2. Open terminal and navigate to the directory of the db.json file.
3. Run `json-server --watch db.json` or `json-server --watch db.json --port [insert desired localhost port numer]`. 
Omitting the `--port` parameter results in running port 3000 by default.

NGROK Localhost porting to online through SSH tunnels.
1. Install NGROK according to the official instructions.
2. Open terminal and make sure you are in the root (`~`) directory. 
3. Check which port you run the json server on (3000 by default, if not set otherwise).
4. Run `./ngrok http port [insert port number here]`.
5. You should get some info about the sucessful tunnelling and a new HTTP URL on which you localhost is accessible through online connection.

Xcode project
1. Open terminal and navigate to the project directory on your machine.
2. Run `pod install`, if necessary, run `pod install --repo-update`. 
3. Open the `.xcworkspace` file in the project directory in Xcode.
- In this section choose whether you want to run the app using a localhost API (simulator only) or NGROK ported, online API (both simulator and real device).
- In both cases make sure that in `NetworkingClient.swift` the `urlBase` constant is set to the right String value, which should be either the localhost or NGROK provided URL.
4. Make sure you've got the `fithub-swift-client` build schema selected.
5. Choose the desired simulator or other device you want to build on. (iPhones only, iPhone X or newer, iOS 12.4 or newer).
6. Build or run the app.

## Running the tests

To run the tests simply use the keyboard shortcut CMD+U. This will trigger a new build and automated tests.

### Tests, explained.

## Built With

* [Xcode](https://developer.apple.com/xcode/) - iOS IDE from Apple.
* [Swift 5](https://swift.org) - iOS development language
* [Cocoapods](https://cocoapods.org) - Dependency manager in iOS development
* [Alamofire](https://github.com/Alamofire/Alamofire) - HTTP networking library
* [Easypeasy](https://github.com/nakiostudio/EasyPeasy) - Swift Autolayout Framework
* [RxSwift](https://github.com/ReactiveX/RxSwift) - Reactive Programming in Swift
* [JSON Server](https://github.com/typicode/json-server) - JS REST API framework (for both local and online dev environment) (outside this repo)
* [NGROK](https://ngrok.com) - SSH tunnels tool for exposing local APIs in mobile development testing (outside this repo)

## Contributing

As this is a university project, no contribution is desired nor allowed. 

## Authors

* **Dominik Urbaez Gomez** - [Github profile](https://github.com/durbaezgomez)

## License

This project is licensed under the exclusive university license.

## Acknowledgments

Useful resources used in the development of this project:
* [Ray Wenderlich forum](https://www.raywenderlich.com)
* [Let's Build That App YouTube channel](https://www.youtube.com/channel/UCuP2vJ6kRutQBfRmdcI92mA)
* [Apple Developer Documentation](https://developer.apple.com/documentation/)
* [Swift by Sundell](https://www.swiftbysundell.com/)
* [Swift & iOS13 Complete Bootcamp](https://www.udemy.com/course/ios-13-app-development-bootcamp/)
