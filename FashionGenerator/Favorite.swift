//
//  Favorite.swift
//  FashionGenerator
//
//  Created by iosdev on 13.11.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import UIKit

class Favorite {
    var name: String
    var photo: UIImage?
    var info: String
    
    
    init?(name: String, info: String, photo: UIImage?) {
        guard !name.isEmpty else {
            return nil
        }
        self.name = name
        self.info = info
        self.photo = photo
    }
}
