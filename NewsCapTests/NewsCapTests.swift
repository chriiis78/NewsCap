//
//  NewsCapTests.swift
//  NewsCapTests
//
//  Created by Chris on 13/05/2020.
//  Copyright © 2020 Chris78. All rights reserved.
//

import XCTest
@testable import NewsCap

class NewsCapTests: XCTestCase {

    class MockListArticleViewController: ListArticleDisplayLogic {
        func displayArticles(viewModel: ListArticle.Fetch.ViewModel) {
        }

        var displayErrorCalled = false
        var displayErrorMessage: String?
        func displayError(viewModel: ListArticle.Fetch.ViewModel.Error) {
            displayErrorCalled = true
            displayErrorMessage = viewModel.errorMessage
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the
        // invocation of each test method in the class.
    }

    func testErrorMessage() throws {
        let mock = MockListArticleViewController()
        let presenter = NewsCap.ListArticlePresenter()
        presenter.viewController = mock

        presenter.presentError(response: NewsCap.ListArticle.Fetch.Response(errorMessage: "Error"))
        XCTAssertTrue(mock.displayErrorCalled)
        XCTAssertEqual(mock.displayErrorMessage, "Error")
    }
}
