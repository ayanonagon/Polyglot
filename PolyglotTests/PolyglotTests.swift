//
//  PolyglotTests.swift
//  PolyglotTests
//
//  Created by Ayaka Nonaka on 7/27/14.
//  Copyright (c) 2014 Ayaka Nonaka. All rights reserved.
//

import UIKit
import XCTest
import Polyglot

class PolyglotTests: XCTestCase {

    func testInit()
    {
        let polyglot: Polyglot = Polyglot(clientId: "myClientId", clientSecret: "myClientSecret")
        XCTAssertNil(polyglot.fromLanguage)
        XCTAssertEqual(polyglot.toLanguage, "en")
    }
}
