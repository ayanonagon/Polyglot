Polyglot
========

[![Build Status](https://travis-ci.org/ayanonagon/Polyglot.svg)](https://travis-ci.org/ayanonagon/Polyglot)

Swift wrapper around Microsoft Translate API. By default, it translates to English from whatever language is detected.

## Basic Usage

Create a new ```Polyglot``` instance.
```swift
let translator = Polyglot(clientId: "YOUR_CLIENT_ID", clientSecret: "YOUR_CLIENT_SECRET")
```

You can optionally specify to & from language codes.
```swift
translator.fromLanguage = Language.Dutch // It will automatically detect the language if you don't set this.
translator.toLanguage = Language.English // English. This is the default.
```

Start translating.
```swift
let dutch = "Ik weet het niet."
translator.translate(dutch) { translation in
    println("\"\(dutch)\" means \"\(translation)\"")
}
```

Check out the [sample project](https://github.com/ayanonagon/Polyglot/tree/master/PolyglotSample) for a quick demo.

## Setting up an account for Microsoft Translate

1. Subscribe to the Microsoft Translate service [here](https://datamarket.azure.com/dataset/bing/microsofttranslator). You’ll probably need to set up a new account first. Good luck. :trollface:
2. Create a new application [here](https://datamarket.azure.com/developer/applications). This is where you will be given a client ID and client secret (which you will need for using Polyglot).

## Dependencies

Because Microsoft’s Translate API returns XML, Polyglot depends on [Ono](https://github.com/mattt/Ono). You should add it to your project however you like ([CocoaPods](http://cocoapods.org/) is recommended), and add it to your target’s [bridging header](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html). When CocoaPods fully supports Swift, this process will become a lot simpler. :octocat:

## Contributing

We’d love to see your ideas for improving this library! The best way to contribute is by submitting a pull request. We’ll do our best to respond to your patch as soon as possible. You can also submit a [new GitHub issue](https://github.com/ayanonagon/Polyglot/issues/new) if you find bugs or have questions. :octocat:

Please make sure to follow our general coding style and add test coverage for new features!
