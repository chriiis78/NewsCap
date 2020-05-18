//
//  ShowArticleInteractor.swift
//  NewsCap
//
//  Created by Chris on 14/05/2020.
//  Copyright (c) 2020 Chris78. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ShowArticleBusinessLogic
{
    func getArticle(request: ShowArticle.GetArticle.Request)
    func fetchArticleImage(request: ShowArticle.FetchImage.Request)
}

protocol ShowArticleDataStore
{
    var article: Article! { get set }
}

class ShowArticleInteractor: ShowArticleBusinessLogic, ShowArticleDataStore
{
    var article: Article!
    
    var presenter: ShowArticlePresentationLogic?
    var worker: ShowArticleWorker?
    var articlesWorker = ArticlesWorker()
    
    // MARK: Do something
    
    func getArticle(request: ShowArticle.GetArticle.Request)
    {
        let response = ShowArticle.GetArticle.Response(article: article)
        presenter?.presentArticle(response: response)
        
        if let url = article.urlToImage {
            fetchArticleImage(request: ShowArticle.FetchImage.Request(url: url))
        }
    }
    
    func fetchArticleImage(request: ShowArticle.FetchImage.Request)
    {
        let req = ArticlesModel.FetchImage.Request(url: request.url)
        articlesWorker.fetchImage(request: req, success: { response in
            let resp = ShowArticle.FetchImage.Response(image: response.image, isError: response.isError)
            self.presenter?.presentArticleImage(response: resp)
        }, fail: { error in
            let resp = ShowArticle.FetchImage.Response(isError: error.isError, message: error.message)
            self.presenter?.presentArticleImage(response: resp)
        })
    }
}
