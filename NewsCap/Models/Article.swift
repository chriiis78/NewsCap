//
//  Article.swift
//  NewsCap
//
//  Created by Chris on 14/05/2020.
//  Copyright © 2020 Chris78. All rights reserved.
//

struct ArticleResult: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
}

struct Article: Codable {
    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}

struct Source: Codable {
    var id: String?
    var name: String?
}
