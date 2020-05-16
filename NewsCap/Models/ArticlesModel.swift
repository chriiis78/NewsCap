//
//  ArticlesModel.swift
//  NewsCap
//
//  Created by Chris on 16/05/2020.
//  Copyright © 2020 Chris78. All rights reserved.
//

import UIKit

struct ArticlesModel
{
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
    }
}
