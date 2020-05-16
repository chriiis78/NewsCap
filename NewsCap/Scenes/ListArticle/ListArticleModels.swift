//
//  ListArticleModels.swift
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

enum ListArticle
{
    // MARK: Use cases
    
    enum Fetch
    {
        struct Request
        {
        }
        struct Response
        {
            var articles: [Article]
            var isError: Bool
            var message: String?
        }
        struct ViewModel
        {
            struct DisplayArticle {
                var imageUrl: String
                var image: UIImage?
                var title: String
                var description: String
            }
            var DisplayArticles: [DisplayArticle]
            var isError: Bool
            var message: String?
            var isImageSet: Bool = false
        }
    }
    
    enum FetchImage
    {
        struct Request
        {
            var url: String
        }
        struct Response
        {
            var imageUrl: String?
            var image: UIImage?
            var isError: Bool
            var message: String?
        }
        struct ViewModel
        {
            var imageUrl: String
            var image: UIImage?
        }
    }
}
