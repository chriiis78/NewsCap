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
                print(String(data: json, encoding: .utf8)!)
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
    
    func fetchImage(request: ListArticle.FetchImage.Request, success:@escaping(imageResponseHandler), fail:@escaping(imageResponseHandler)) {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = URL(fileURLWithPath: path)
        let fileName = URL(fileURLWithPath: request.url).lastPathComponent
        print("fileName \(fileName)")
        let pathComponent = url.appendingPathComponent(fileName)
        let filePath = pathComponent.path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            print("FILE AVAILABLE")
            if let image = UIImage(contentsOfFile: filePath) {
                success(ArticlesModel.FetchImage.Response(imageUrl: request.url, image: image, isError: false))
            } else {
                fail(ArticlesModel.FetchImage.Response(isError: true, message: "no image found"))
            }
            
        } else {
            print("FILE NOT AVAILABLE")
            
            let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
            
            let requestImage = AF.download(request.url, to: destination)
            
            requestImage.response { response in
                print(response)
                switch response.result {
                case .success:
                    if fileManager.fileExists(atPath: filePath) {
                        print("FILE AVAILABLE")
                        if let image = UIImage(contentsOfFile: filePath) {
                            success(ArticlesModel.FetchImage.Response(imageUrl: request.url, image: image, isError: false))
                        } else {
                            fail(ArticlesModel.FetchImage.Response(isError: true, message: "no image found"))
                        }
                        
                    }
                case let .failure(error):
                    fail(ArticlesModel.FetchImage.Response(isError: true, message: error.errorDescription))
                }
            }
        }
    }
}

