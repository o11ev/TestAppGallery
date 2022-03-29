//
//  DataModel.swift
//  TestAppGallery
//
//  Created by Olga Dragunova on 29.03.2022.
//

import Foundation

struct DataModel: Decodable {
    var response: Response
}

struct Response: Decodable {
    var items: [Item]
    var count: Int
}

struct Item: Decodable {
    var date: Int
    var sizes: [Size]
}

struct Size: Decodable {
    var url: String
    var type: String
}
