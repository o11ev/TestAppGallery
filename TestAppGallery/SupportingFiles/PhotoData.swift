//
//  DataModel.swift
//  TestAppGallery
//
//  Created by Olga Dragunova on 29.03.2022.
//

import Foundation

struct PhotoData: Decodable {
    var response: Response
}

struct Response: Decodable {
    var items: [Items]
    var count: Int
}

struct Items: Decodable {
    var date: Int
    var sizes: [Sizes]
}

struct Sizes: Decodable {
    var url: String
    var type: String
}
