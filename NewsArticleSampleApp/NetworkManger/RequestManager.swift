//
//  RequestManager.swift
//  NewsArticleSampleApp
//
//  Created by Rakesh Medpalli on 01/07/22.
//

import Foundation

public typealias CompletionHandler = (_ isSuccess: Bool, Data?) -> Void

class RequestManager: NSObject {
    static let sharedInstance = RequestManager()
    private override init() { }
    
    func readLocalJSONFile() -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: "MockResponse", ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
    func requestAPI(requestURN: RequestURN, completionHandler: @escaping CompletionHandler ) {
        if requestURN.isMockHTTPRequest {
            DispatchQueue.main.async {
                let responseData = self.readLocalJSONFile()
                completionHandler(true, responseData)
            }
        }else {
            
            guard let url = constructURL(requestURN) else {
                completionHandler(false,nil)
                return
            }
            
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let request = URLRequest(url: url)
            let task = session.dataTask(with: request) { (data, response, error) in
                guard error == nil else {
                    completionHandler(false,nil)
                    return
                }
                guard let responseData = data else {
                    completionHandler(false,nil)
                    return
                }
                completionHandler(true, responseData)
            }
            task.resume()
        }
    }
    
    private func constructURL(_ requestURN: RequestURN) -> URL? {
        if requestURN.urn.isEmpty { return nil}
        if let url = URL(string: APIConst.hostName+requestURN.urn) {
            print(url)
            return url
        }
        return nil
    }
}
