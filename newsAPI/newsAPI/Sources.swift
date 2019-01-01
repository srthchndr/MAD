//
//  Sources.swift
//  newsAPI
//
//  Created by Sarath Madala on 10/14/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

import Foundation

struct SourceList: Codable {
    var sources: [Sources]
}

class Sources: Codable{
    let id : String?
    let name : String?
    let description : String?
    let url : String?
    let category : String?
    let language : String?
    let country : String?
    
    init(id : String, name : String, description : String, url : String, category : String, language : String, country : String) {
        self.id = id
        self.name = name
        self.description = description
        self.url = url
        self.category = category
        self.language = language
        self.country = country
    }
}
