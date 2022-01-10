//
//  ZircleAPI.swift
//  FashionGenerator
//
//  Created by iosdev on 20.11.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ZircleAPI {
    fileprivate var baseUrl = ""
    var clothesArray = [ClothesItem]()
    var imageArray = [UIImage]()
    
    init(baseUrl: String){
        self.baseUrl = baseUrl
    }
    
    func getClothesArray()-> Array<ClothesItem>{
        print(self.clothesArray)
        return self.clothesArray
    }
    
    // MARK: GET CLOTHES DATA
    func getData() {
        var clothesDataArray = [NSManagedObject]()
        let parameters = "{\r\n  \"max_price\": 10\r\n}\r\n"
        let postData = parameters.data(using: .utf8)
        var request = URLRequest(url: URL(string: "https://api.zalando-wardrobe.de/api/marketplace/groups/all/all_items/search?sort=created_at&sort_direction=desc&b2c=true&c2c=true")!,timeoutInterval: Double.infinity)

        request.addValue("9hC4HxmqRe7NG3HDPg9c6WEj", forHTTPHeaderField: "x-wardrobe-apikey")

        request.addValue("text/plain", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
 
    let task = URLSession.shared.dataTask(with: request) { data, response, error in if let error = error {
        print("Client error \(error)")
        }

        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
                return
        }
        
        if let data = data, let _ = String(data: data, encoding: .utf8) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }

            let managedContext = appDelegate.persistentContainer.viewContext
            guard let entity = NSEntityDescription.entity(forEntityName: "Cloth", in: managedContext) else { return  }
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cloth")
            var saveCheck = false

            do {
                           print("fetching data")
                           clothesDataArray = try managedContext.fetch(fetchRequest)
                           
                       } catch let error as NSError {
                           print("Could not fetch. \(error), \(error.userInfo)")
                       }

            do {

               let decoder = JSONDecoder()
               let clothes = try decoder.decode(Clothes.self, from: data)

                for item in clothes.items {
                    for dataItem in clothesDataArray {
                        if dataItem.value(forKey: "id") as? String == item.item.id {
                            saveCheck = true
                        }
                    }

                    if (!saveCheck){
                    managedContext.perform {
                                 
                    let clothesItem = NSManagedObject(entity: entity, insertInto: managedContext)
                        
                        clothesItem.setValue(item.item.id, forKeyPath: "id")
                        clothesItem.setValue(item.item.brand, forKey: "brand")
                        clothesItem.setValue(item.item.images.first!.url, forKey: "imageUrl")
                        clothesItem.setValue(item.item.category, forKey: "category")
                        clothesItem.setValue(item.item.size, forKey: "size")
                        clothesItem.setValue(item.item.price.amount, forKey: "price")
                        
                        do {
                        //    let vc = ViewController()
                            try managedContext.save()
                         //   vc.clothes.append(clothesItem)
                            print("item saved!")
                            //filteredData.append(newsItem)
                        } catch let error as NSError {
                            print("Could not save. \(error), \(error.userInfo)")
                        }
                    }
                    } else {
                        print("Item not saved, allready exists")
                    }
                    
                    let newItem = ClothesItem(id: item.item.id, brand: item.item.brand, category: item.item.category,size: item.item.size, price: item.item.price.amount, imageUrl: item.item.images.first!.url)
                    
                self.clothesArray.append(newItem)
                    print(newItem.price)
                }
            }catch let error {
                print("Error", error)
            }
        }
    }
    task.resume()
    }
    
    //MARK: GET IMAGE
    func getImage(imgUrl: String) -> Array<UIImage> {
           var request = URLRequest(url: URL(string: imgUrl)!,timeoutInterval: Double.infinity)

           request.addValue("9hC4HxmqRe7NG3HDPg9c6WEj", forHTTPHeaderField: "x-wardrobe-apikey")
           
           request.httpMethod = "GET"
    
       let task = URLSession.shared.dataTask(with: request) { data, response, error in if let error = error {
           print("Client error \(error)")
           }
            print("haloo")
           guard let httpResponse = response as? HTTPURLResponse,
               (200...299).contains(httpResponse.statusCode) else {
                   return
           }
        
          guard let data = data else {
            print(String(describing: error))
            return
          }
       let image = UIImage(data: data)
        self.imageArray.append(image!)
        }
     
       task.resume()
        return imageArray
       }

}

    


