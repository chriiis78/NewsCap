//
//  ListArticlePresenter.swift
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

protocol ListArticlePresentationLogic {
    func presentArticles(response: ListArticle.FetchArticles.Response)
}

class ListArticlePresenter: ListArticlePresentationLogic {
    weak var viewController: ListArticleDisplayLogic?

    // MARK: Present Articles

    func presentArticles(response: ListArticle.FetchArticles.Response) {
        var displayArticles = [ListArticle.FetchArticles.ViewModel.DisplayArticle]()

        for article in response.articles {
            let imageUrl = article.urlToImage ?? ""
            let title = article.title ?? ""

            var description = ""
            if let desc = article.description, !desc.isEmpty {
                description = desc
            } else {
                description = article.content ?? ""
            }

            let displayArticle = ListArticle.FetchArticles.ViewModel.DisplayArticle(
                imageUrl: imageUrl,
                title: title,
                description: description)
            displayArticles.append(displayArticle)
        }

        let viewModel = ListArticle.FetchArticles.ViewModel(
            displayArticles: displayArticles,
            isError: response.isError,
            message: response.message)
        viewController?.displayArticles(viewModel: viewModel)
    }
}
