//
//  RequestURN.swift
//  NewsArticleSampleApp
//
//  Created by Rakesh Medpalli on 01/07/22.
//

import Foundation
protocol RequestURN {
    var url: String { get }
    var urn: String { get }
    var httpMethod: String? { get  }
    var isMockHTTPRequest: Bool { get }
}

extension RequestURN {
    
    var url: String {
        return ""
    }
    
    var urn: String {
        return ""
    }

    var httpMethod: String? {
        return "GET"
    }
    
    var isMockHTTPRequest: Bool {
        return false
    }
   
}

