//
//  Clothes.swift
//  FashionGenerator
//
//  Created by iosdev on 25.11.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import Foundation

struct Clothes: Codable {
    var title:[Title]
    var items:[Item]
    var allowed_filter_types:[Types]
    let totalcount: TotalCount?

    
    private enum CodingKeys: String, CodingKey {
        case title
        case items
        case allowed_filter_types
        case totalcount
    }
    
    struct Title: Codable{
        var lang: String
        var value: String
    }
    
    struct Item: Codable{
        var item:ItemSpecs
        var user: User
    }
    
    struct ItemSpecs: Codable {
        var id: String
        var brand: String
        var category: String
        var size: String
        var price: Prices
        var images: [Images]
        var is_mine: Bool
        var is_webshop: Bool
    }
    
    struct User: Codable {
        var user_id: String
        var profile_name: String
        var profile_image_url: URL?
        var is_verified: Bool
    }
    
    struct Images: Codable {
        var id: String
        var url: URL
    }
    
    struct Prices: Codable {
        var amount: Double
        var currency: String
    }
    
    struct TotalCount: Codable{
        var value: Int
        var relation: String
    }
    
    struct Types: Codable {
        
    }
}
