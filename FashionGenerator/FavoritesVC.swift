//
//  FavoritesVC.swift
//  FashionGenerator
//
//  Created by iosdev on 13.11.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var favorites = [Favorite]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 90.0
        loadSampleFavorites()
    }
    
    private func loadSampleFavorites() {
        let photo1 = UIImage(named: "shirt1")
        let photo2 = UIImage(named: "shirt2")
        let photo3 = UIImage(named: "shirt3")
        
        guard let fav1 = Favorite(name: "Paituli", info: "hieno", photo: photo1) else {
            fatalError("favorite failed")
        }
        
        guard let fav2 = Favorite(name: "Puituli", info: " ei niin hieno", photo: photo2) else {
            fatalError("favorite failed")
        }
        
        guard let fav3 = Favorite(name: "Jumpperi", info: "ruma", photo: photo3) else {
            fatalError("favorite failed")
        }
        favorites += [fav1,fav2,fav3,fav1,fav2,fav3,fav1,fav2,fav3,fav1,fav2,fav3,fav1,fav2,fav3]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as? FavoritesTableViewCell else {
            fatalError("FavoritesTableViewCell error")
        }
        
        if(indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.systemBlue
        } else {
            cell.backgroundColor = UIColor.systemTeal
        }
        let favorite = favorites[indexPath.row]
        cell.nameLabel.text = favorite.name
        cell.infoLabel.text = favorite.info
        cell.photoImageView.image = favorite.photo
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "viewFavorite") {
            if let destination = segue.destination as? SingleFavoriteVC {
                let data =  favorites[(tableView.indexPathForSelectedRow?.row ?? 0)]
                destination.favorite = data
            }
        }
    }
}
