Vertaler
========

Swift wrapper around Microsoft Translate API. By default, it translates to English from whatever language is detected.

## Setting up an account for Microsoft Translate

1. Subscribe to the Microsoft Translate service [here](https://datamarket.azure.com/dataset/bing/microsofttranslator). You'll probably need to set up a new account first. Good luck. :trollface:
2. Create a new application [here](https://datamarket.azure.com/developer/applications). This is where you will be given a client ID and client secret (which you will need for using Vertaler).

## Basic Usage

Create a new ```Vertaler``` ("translator") instance.
```swift
let translator = Vertaler(clientId: "YOUR_CLIENT_ID", clientSecret: "YOUR_CLIENT_SECRET")
```

Start translating.
```swift
let dutch = "Ik weet het niet."
translator.translate(dutch) { translation in
   println(String(format: "\"%@\" means \"%@\"", dutch, translation))
}
```
