//
//  ClothesItem.swift
//  FashionGenerator
//
//  Created by iosdev on 26.11.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import Foundation

class ClothesItem {
    let brand: String
    let category: String
    let size: String
    let price: Double
    let imageUrl: URL
    let id: String
    
    init(id: String, brand: String, category: String, size: String, price: Double, imageUrl: URL) {
        self.id = id
        self.brand = brand
        self.category = category
        self.size = size
        self.price = price
        self.imageUrl = imageUrl
    }
}
