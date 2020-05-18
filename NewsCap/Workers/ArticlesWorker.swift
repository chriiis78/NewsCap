//
//  ArticlesWorker.swift
//  NewsCap
//
//  Created by Chris on 16/05/2020.
//  Copyright © 2020 Chris78. All rights reserved.
//

import UIKit
import Alamofire

typealias responseHandler = (_ response:ArticlesModel.Fetch.Response) ->()
typealias imageResponseHandler = (_ response:ArticlesModel.FetchImage.Response) ->()

class ArticlesWorker
{
    func fetch(success:@escaping(responseHandler), fail:@escaping(responseHandler))
    {
        guard let api_url = Bundle.main.infoDictionary?["NEWSAPI_URL"] as? String,
            let api_key = Bundle.main.infoDictionary?["NEWSAPI_KEY"] as? String,
            let api_country = Bundle.main.infoDictionary?["NEWSAPI_COUNTRY"] as? String
            else {
                print("error get API parameters")
                fail(ArticlesModel.Fetch.Response(articles: [], isError: true, message: "error get API parameters"))
                return
        }
        
        let parameters: Parameters = [
            "country" : api_country,
            "apiKey" : api_key
        ]
        
        let request = AF.request(api_url,
                                 method: .get,
                                 parameters: parameters)
        
        request.responseData { response in
            let decoder = JSONDecoder()
            switch response.result {
            case .success:
                let json = response.data!
                var articleResult: ArticleResult
                do {
                    articleResult = try decoder.decode(ArticleResult.self, from: json)
                    success(ArticlesModel.Fetch.Response(articles: articleResult.articles!, isError: false, message: nil))
                } catch {
                    print(error.localizedDescription)
                    fail(ArticlesModel.Fetch.Response(articles: [], isError: true, message: error.localizedDescription))
                }
            case let .failure(error):
                print(error)
                fail(ArticlesModel.Fetch.Response(articles: [], isError: true, message: error.errorDescription))
            }
        }
    }
    
    func fetchImage(request: ArticlesModel.FetchImage.Request, success:@escaping(imageResponseHandler), fail:@escaping(imageResponseHandler)) {
        
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let pathComponent = documentURL.appendingPathComponent(request.url)
        let filePath = pathComponent.path
        print("fileName \(filePath)")
        
        if fileManager.fileExists(atPath: filePath) {
            print("FILE AVAILABLE")
            if let image = UIImage(contentsOfFile: filePath) {
                success(ArticlesModel.FetchImage.Response(imageUrl: request.url, image: image, isError: false))
            } else {
                fail(ArticlesModel.FetchImage.Response(isError: true, message: "no image found"))
            }
        } else {
            print("DOWNLOAD FILE \(filePath)")
            
            let destination: DownloadRequest.Destination = { _, _ in
                return (pathComponent, [.removePreviousFile, .createIntermediateDirectories])
            }
            
            let requestImage = AF.download(request.url, to: destination)
            
            requestImage.responseData { response in
                print("RESPONSE \(filePath)")
                switch response.result {
                case .success:
                    success(ArticlesModel.FetchImage.Response(imageUrl: request.url, image: UIImage(data: response.value!), isError: false))
                case let .failure(error):
                    print("ERROR")
                    print(error.errorDescription.debugDescription)
                    fail(ArticlesModel.FetchImage.Response(isError: true, message: error.errorDescription))
                }
            }
        }
    }
}

