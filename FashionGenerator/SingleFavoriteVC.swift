//
//  SingleFavoriteVC.swift
//  FashionGenerator
//
//  Created by iosdev on 16.11.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import UIKit

class SingleFavoriteVC: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var singleFavoriteLabel: UILabel!
    @IBOutlet weak var singleFavoriteImage: UIImageView!
    @IBOutlet weak var singleFavoriteInfo: UILabel!
    
    var favorite: Favorite?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        singleFavoriteInfo.text = favorite?.info
        singleFavoriteImage.image = favorite?.photo
        singleFavoriteLabel.text = favorite?.name
    }
}
