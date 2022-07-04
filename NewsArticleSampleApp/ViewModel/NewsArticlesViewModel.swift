//
//  NewsArticlesViewModel.swift
//  NewsArticleSampleApp
//
//  Created by Rakesh Medpalli on 01/07/22.
//

import Foundation

protocol ResponseHandler: AnyObject {
    func updateUI()
    func onError()
}

class NewsArticlesViewModel: NSObject {
    weak var delegate : ResponseHandler?
    var responseModel: NewArticlesModel?
    
    func getNewsArticlesList<T: RequestURN>(requestModel : T) {
        RequestManager.sharedInstance.requestAPI(requestURN: requestModel) { isSuccess, responseData in
            if isSuccess {
                guard let responseData = responseData, !responseData.isEmpty else {
                    self.delegate?.onError()
                    return
                }
                self.parseResponse(jsonData: responseData)
            }else {
                self.delegate?.onError()
            }
        }
    }
    
    func parseResponse(jsonData: Data ) {
        do {
            let responModel = try JSONDecoder().decode(NewArticlesModel.self, from: jsonData)
            self.responseModel = responModel
            self.delegate?.updateUI()
        } catch {
            print(error)
            self.delegate?.onError()
        }
    }
    
    func getCellCount() -> Int {
        self.responseModel?.results?.count ?? 0
    }
    
}
