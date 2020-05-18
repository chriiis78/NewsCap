//
//  ListArticleInteractor.swift
//  ListArticleCap
//
//  Created by Chris on 13/05/2020.
//  Copyright (c) 2020 Chris78. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListArticleBusinessLogic
{
    func fetchArticles(request: ListArticle.Fetch.Request)
    func fetchArticleImage(request: ListArticle.FetchImage.Request)
}

protocol ListArticleDataStore
{
    //var name: String { get set }
    var articles: [Article]? { get }
}

class ListArticleInteractor: ListArticleBusinessLogic, ListArticleDataStore
{
    var articles: [Article]?
    
    var presenter: ListArticlePresentationLogic?
    var worker: ListArticleWorker?
    var articlesWorker = ArticlesWorker()
    //var name: String = ""
    
    // MARK: Do something
    
    func fetchArticles(request: ListArticle.Fetch.Request)
    {
        articlesWorker.fetch(success: { response in
            self.articles = response.articles
            let resp = ListArticle.Fetch.Response(articles: response.articles, isError: response.isError, message: response.message)
            self.presenter?.presentArticles(response: resp)
            self.fetchArticlesImage()
        }, fail: { error in
            let resp = ListArticle.Fetch.Response(articles: [], isError: error.isError, message: error.message)
            self.presenter?.presentArticles(response: resp)
        })
    }
    
    func fetchArticlesImage()
    {
        if let articles = articles {
            for (index, article) in articles.enumerated() {
                if let url = article.urlToImage {
                    let request = ListArticle.FetchImage.Request(index: index, url: url)
                    fetchArticleImage(request: request)
                }
            }
        }
    }
    
    func fetchArticleImage(request: ListArticle.FetchImage.Request)
    {
        let req = ArticlesModel.FetchImage.Request(url: request.url)
        articlesWorker.fetchImage(request: req, success: { response in
            let resp = ListArticle.FetchImage.Response(index: request.index, image: response.image, isError: response.isError)
            self.presenter?.presentArticleImage(response: resp)
        }, fail: { error in
            let resp = ListArticle.FetchImage.Response(index: request.index, isError: error.isError, message: error.message)
            self.presenter?.presentArticleImage(response: resp)
        })
    }
}
