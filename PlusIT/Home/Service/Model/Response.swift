//
//  Product.swift
//  PlusIT
//
//  Created by Diego Rodrigues Abdala Uthman on 28/02/22.
//

import Foundation

public struct Response: Decodable {
    var spotlight: [Spotlight]
    var products: [Product]
    var cash: Cash
}

public struct Spotlight: Codable {
    var name: String
    var bannerURL: String
    var description: String
}

public struct Product: Codable {
    var name: String
    var imageURL: String
    var description: String
}

public struct Cash: Codable {
    var title: String
    var bannerURL: String
    var description: String
}

