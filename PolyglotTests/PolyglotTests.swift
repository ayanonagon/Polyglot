// PolyglotTests.swift
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

import UIKit
import XCTest
import Polyglot
import Nocilla

class PolyglotTests: XCTestCase {

    override func setUp() {
        super.setUp()
        LSNocilla.sharedInstance().start()
    }

    override func tearDown() {
        super.tearDown()
        LSNocilla.sharedInstance().clearStubs()
        LSNocilla.sharedInstance().stop()
    }

    func testInit() {
        let polyglot: Polyglot = Polyglot(clientId: "myClientId", clientSecret: "myClientSecret")
        XCTAssertNil(polyglot.fromLanguage?.rawValue)
        XCTAssertEqual(polyglot.toLanguage, Language.English)
    }

    func testTranslate() {
        let expectation = expectationWithDescription("translation done")

        // Stub POST access token
        stubRequest("POST", "https://datamarket.accesscontrol.windows.net/v2/OAuth2-13")
        .withBody("client_id=myClientId&client_secret=myClientSecret&scope=http://api.microsofttranslator.com&grant_type=client_credentials".dataUsingEncoding(NSUTF8StringEncoding))
        .andReturn(200)
        .withHeaders(["Content-Type": "application/json"])
        .withBody("{\"access_token\":\"octocatsruleeverythingaroundme\", \"expires_in\":\"600\"}")

        // Stub GET translation
        stubRequest("GET", "http://api.microsofttranslator.com/v2/Http.svc/Translate?text=Ik%20weet%20het%20niet&to=en&from=nl")
        .withHeader("Authorization", "Bearer octocatsruleeverythingaroundme")
        .andReturn(200)
        .withBody("<string xmlns=\"http://schemas.microsoft.com/2003/10/Serialization/\">I don't know</string>")

        let polyglot: Polyglot = Polyglot(clientId: "myClientId", clientSecret: "myClientSecret")
        polyglot.translate("Ik weet het niet") { (translation, error) in
            
            guard let translation = translation else { return }
            XCTAssertEqual(translation, "I don't know")
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(1, handler: nil)
    }
}
