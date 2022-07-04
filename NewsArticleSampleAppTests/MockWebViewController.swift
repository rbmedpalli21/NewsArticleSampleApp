//
//  MockViewController.swift
//  NewsArticleSampleAppTests
//
//  Created by Rakesh Medpalli on 02/07/22.
//

import XCTest
@testable import NewsArticleSampleApp

class MockWebViewController: XCTestCase {
    func testProperties() {
        let webVC = NewsArticleWebViewVC()
        webVC.urlStr =  "www.google.com"
        webVC.loadView()
        XCTAssertNotNil(webVC.urlStr)
    }
}
