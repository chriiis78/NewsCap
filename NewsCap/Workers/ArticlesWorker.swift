//
//  ArticlesWorker.swift
//  NewsCap
//
//  Created by Chris on 16/05/2020.
//  Copyright © 2020 Chris78. All rights reserved.
//

import UIKit
import Alamofire

typealias ResponseHandler = (_ response: ArticlesModel.Fetch.Response) -> Void

class ArticlesWorker {

    func fetch(success: @escaping(ResponseHandler),
               fail: @escaping(ResponseHandler)) {
        guard let apiUrl = Bundle.main.infoDictionary?["NEWSAPI_URL"] as? String,
            let apiKey = Bundle.main.infoDictionary?["NEWSAPI_KEY"] as? String,
            let apiCountry = Bundle.main.infoDictionary?["NEWSAPI_COUNTRY"] as? String
            else {
                print("error get API parameters")
                fail(ArticlesModel.Fetch.Response(errorMessage: "error get API parameters"))
                return
        }

        let parameters: Parameters = [
            "country": apiCountry,
            "apiKey": apiKey
        ]

        let request = AF.request(apiUrl, method: .get, parameters: parameters)

        request.responseData { response in
            let decoder = JSONDecoder()
            switch response.result {
            case .success:
                guard let json = response.data else {
                    fail(ArticlesModel.Fetch.Response(errorMessage: "error: no response data"))
                    return
                }
                var articleResult: ArticleResult
                do {
                    articleResult = try decoder.decode(ArticleResult.self, from: json)
                    if let articles = articleResult.articles {
                        success(ArticlesModel.Fetch.Response(
                            articles: articles))
                    } else {
                        fail(ArticlesModel.Fetch.Response(errorMessage: "error: no article in data"))
                    }
                } catch {
                    print(error.localizedDescription)
                    fail(ArticlesModel.Fetch.Response(errorMessage: error.localizedDescription))
                }
            case let .failure(error):
                print(error)
                fail(ArticlesModel.Fetch.Response(errorMessage: error.errorDescription))
            }
        }
    }
}
