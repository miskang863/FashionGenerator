//
//  UserSettings.swift
//  FashionGenerator
//
//  Created by iosdev on 27.11.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import Foundation
class UserSettings {

    var priceRange: Double
    var category: [String]
    var size: String
    var size2: String

    init (priceRange: Double, category: [String], size: String, size2: String) {
    self.priceRange = priceRange
    self.category = category
    self.size = size
    self.size2 = size2
}
}
        // Do any additional setup after loading the view.
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


