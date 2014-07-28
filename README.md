Vertaler
========

Swift wrapper around Microsoft Translate API. It currently translates only Dutch to English.

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
