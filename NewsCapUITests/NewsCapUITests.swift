//
//  NewsCapUITests.swift
//  NewsCapUITests
//
//  Created by Chris on 13/05/2020.
//  Copyright © 2020 Chris78. All rights reserved.
//

import XCTest
@testable import NewsCap

class NewsCapUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as
        // interface orientation - required for your tests before they run.
        // The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation
        // of each test method in the class.
    }

    func testShowArticle() throws {
        let app = XCUIApplication()
        app.launch()

        app.tables.cells.element(boundBy: 0).tap()
        XCUIApplication().navigationBars["NewsCap.ShowArticleView"].buttons["News"].press(forDuration: 0.5)

        app.tables.cells.element(boundBy: 0).tap()
        app.scrollViews.otherElements.buttons.element(boundBy: 0).tap()
    }

    func testSearch() throws {
        let app = XCUIApplication()
        app.launch()

        let newsNavigationBar = app.navigationBars["News"]
        let searchNewsSearchField = newsNavigationBar.searchFields["Search News"]
        searchNewsSearchField.tap()

        let cKey = app.keys["C"]
        cKey.tap()

        let oKey = app.keys["o"]
        oKey.tap()
        oKey.tap()

        let deleteKey = app.keys["delete"]
        deleteKey.tap()
        searchNewsSearchField.buttons["Clear text"].tap()
        newsNavigationBar.buttons["Cancel"].tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
