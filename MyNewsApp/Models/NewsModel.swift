//
//  NewsModel.swift
//  MyNewsApp
//
//  Created by Thiago Emanoel on 10/08/23.
//

import Foundation

// Struct agora pode sofrer code e decode

struct NewsModel: Codable {
    var source: SourceModel;
    var author: String?;
    var title: String;
    var description: String?;
    var url: String;
    var urlToImage: String?;
    var publishedAt: Date;
    var content: String?;
    
}
