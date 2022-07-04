//
//  NewsArticleSampleAppTests.swift
//  NewsArticleSampleAppTests
//
//  Created by Rakesh Medpalli on 01/07/22.
//

import XCTest
@testable import NewsArticleSampleApp

struct MockNewArticleReqModel: RequestURN {
    
    var httpMethod: String? {
        return "GET"
    }

    var urn: String {
        return APIConst.restURN+APIKeyConst.key
    }
    
    var isMockHTTPRequest: Bool { true }
}

class NewsArticleSampleAppTests: XCTestCase {
   
    func testExample() throws {
        let reqURNMOdel = MockNewArticleReqModel()
        XCTAssertNotNil(reqURNMOdel.urn)
        XCTAssertNotNil(reqURNMOdel.httpMethod)
        XCTAssertNotNil(reqURNMOdel.isMockHTTPRequest)
        XCTAssertNotNil(reqURNMOdel.url)

        let mockVM = NewsArticlesViewModel()
        mockVM.getNewsArticlesList(requestModel: MockNewArticleReqModel())
        XCTAssertNotNil(mockVM.getCellCount())
    }

}
