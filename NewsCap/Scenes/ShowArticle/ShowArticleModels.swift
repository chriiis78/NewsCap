//
//  ShowArticleModels.swift
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

enum ShowArticle {
    // MARK: Use cases

    enum GetArticle {
        struct Request {
        }
        struct Response {
            var article: Article
        }
        struct ViewModel {
            var imageUrl: String
            var title: String
            var publish: String
            var author: String
            var content: String
            var source: String
            var sourceURL: URL?
        }
    }

    enum FetchImage {
        struct Request {
            var url: String
        }
        struct Response {
            var image: UIImage?
            var isError: Bool
            var message: String?
        }
        struct ViewModel {
            var image: UIImage?
        }
    }
}
