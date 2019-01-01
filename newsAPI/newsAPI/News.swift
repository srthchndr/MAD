//
//  News.swift
//  newsAPI
//
//  Created by Sarath Madala on 9/21/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

import Foundation

struct Articles: Codable {
    var articles: [News]
}

class News: Codable {
    let author : String?
    let title : String?
    let description : String?
    let url : String?
    let urlToImage : String?
    let publishedAt : String?
    let content : String?
    
    init(author: String?, title: String, description: String, url: String, urlToImage: String?, publishedAt: String, content: String?) {
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}

