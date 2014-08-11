// Polyglot.swift
//
// Copyright (c) 2014 Ayaka Nonaka
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

public class Polyglot {

    let session: Session

    public var fromLanguage: String?
    public var toLanguage: String

    public init(clientId: String, clientSecret: String)
    {
        self.session = Session(clientId: clientId, clientSecret: clientSecret)
        self.toLanguage = "en"
    }

    public func translate(text: String, callback: ((translation: String) -> (Void)))
    {
        self.session.getAccessToken { token in
            let toLanguageComponent = "&to=" + self.toLanguage.urlEncoded
            let fromLanguageComponent = (self.fromLanguage != nil) ? "&from=" + self.fromLanguage!.urlEncoded : ""
            let urlString = "http://api.microsofttranslator.com/v2/Http.svc/Translate?text=" + text.urlEncoded + toLanguageComponent + fromLanguageComponent

            let request = NSMutableURLRequest(URL: NSURL(string: urlString))
            request.HTTPMethod = "GET"
            request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")

            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
                let document = ONOXMLDocument.XMLDocumentWithData(data, error: nil)
                let translation = document.rootElement.stringValue();
                callback(translation: translation)
            }
            task.resume()
        }
    }
}
