//
//  ViewController.swift
//  FashionGenerator
//
//  Created by iosdev on 10.11.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//
import UIKit
import SwiftyGif
import Shuffle_iOS
import Alamofire
import AlamofireImage
import CoreData

class ViewController: UIViewController, SwipeCardStackDataSource, SwipeCardStackDelegate {
    
    @IBOutlet weak var mainView: UIView!
    var clothes: [NSManagedObject] = []
    let cardStack = SwipeCardStack()
    var cardImages = [UIImage]()
    var cardBrand = [String]()
    var cardPrice = [Double]()
    //TEST URL FOR IMG
    let testImgUrl = "https://api.zalando-wardrobe.de/api/images/306d0235-ffa4-49b2-b20a-84551b23e9af/content"
    
    //URL FOR API CALL
    let api = ZircleAPI(baseUrl: "https://api.zalando-wardrobe.de/api/marketplace/groups/all/all_items/search?page_size=10&page_number=1&sort=created_at&sort_direction=desc&b2c=true&c2c=true")
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        api.getData()
        
        view.addSubview(mainView)
        mainView.addSubview(cardStack)
        cardStack.frame = mainView.safeAreaLayoutGuide.layoutFrame
        cardStack.layer.shadowColor = UIColor.black.cgColor
        cardStack.layer.shadowOpacity = 0.5
        cardStack.layer.shadowOffset = .zero
        cardStack.layer.shadowRadius = 5
        cardStack.dataSource = self
        cardStack.delegate = self

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cloth")
            
            do {
                print("fetching data")
                clothes = try managedContext.fetch(fetchRequest)
                print("CoreData Loaded. Items found:  \(clothes.count)")
                //     filteredData = try managedContext.fetch(fetchRequest)
                
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        
        for item in clothes {
            let imgurl = item.value(forKeyPath: "imageUrl") as? URL
            getImg2(imgUrl: imgurl?.absoluteString ?? "https://api.zalando-wardrobe.de/api/images/306d0235-ffa4-49b2-b20a-84551b23e9af/content")
            let brand = item.value(forKeyPath: "brand") as? String
            cardBrand.append(brand ?? "empty")
            let price = item.value(forKeyPath: "price") as? Double
            cardPrice.append(price ?? 0.0)
        }

       // api.getImage(imgUrl: testImgUrl)
        view.addSubview(logoAnimationView)
        logoAnimationView.pinEdgesToSuperView()
        logoAnimationView.logoGifImageView.delegate = self
        view.addSubview(cardStack)
        cardStack.frame = view.safeAreaLayoutGuide.layoutFrame
        
}
    
    //MARK: REFRESH BUTTON
    @IBAction func refreshButton(_ sender: UIBarButtonItem) {
     /*   for item in api.getData() {
            print("saving data")
            save(id: item.id, brand: item.brand, category: item.category, size: item.size, price: item.price, imageUrl: item.imageUrl)
        }*/
        print(clothes)


    
    }
    
    // MARK: GET IMAGE CALLS
    // getImg2 works...
    func getImg2(imgUrl: String) {
        let headers:HTTPHeaders = ["x-wardrobe-apikey":"9hC4HxmqRe7NG3HDPg9c6WEj"]
        AF.request(imgUrl, headers: headers).responseImage { response in
        //    debugPrint(response)

            if case .success(let image) = response.result {
                self.cardImages.append(image)
            }
            self.cardStack.dataSource = self
            self.cardStack.delegate = self
        }
    }

   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
     // MARK: SAVE COREDATA FUNC
   /* func save(id: String, brand: String, category: String, size: String, price: Double, imageUrl: URL
    ) {
        var saveCheck = false
        
        for item in clothes {
            if item.value(forKey: "id") as? String == id {
                saveCheck = true
            }
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Cloth", in: managedContext) else { return  }
        
        if (!saveCheck) {
        let clothesItem = NSManagedObject(entity: entity, insertInto: managedContext)
        
        clothesItem.setValue(id, forKeyPath: "id")
        clothesItem.setValue(brand, forKey: "brand")
        clothesItem.setValue(imageUrl, forKey: "imageUrl")
        clothesItem.setValue(category, forKey: "category")
        clothesItem.setValue(size, forKey: "size")

        do {
            try managedContext.save()
            clothes.append(clothesItem)
            print("item saved!")
            //filteredData.append(newsItem)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        } else {
            print("clothesitem allready exists")
        }
    }*/
//MARK: Logo Leftovers
    let logoAnimationView = LogoAnimationView()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoAnimationView.logoGifImageView.startAnimatingGif()
    }
    
    //MARK: Func Card
    func card(fromImage image: UIImage, brand: String, price: Double) -> SwipeCard {
      let card = SwipeCard()
    
      card.swipeDirections = [.left, .right]
      card.content = UIImageView(image: image)
      card.footerHeight = 80
      let leftOverlay = UIView()
        leftOverlay.backgroundColor = .red

      card.layer.cornerRadius = 10
      
        
     
        let leftOverlayText = UILabel(frame: CGRect(x: 50, y: 100, width: 300, height: 300))
        leftOverlayText.textColor = .red
        leftOverlayText.text = "NOPE"
        leftOverlayText.font = leftOverlayText.font.withSize(100)
        
     
        let rightOverlayText = UILabel(frame: CGRect(x: 50, y: 100, width: 300, height: 300))
             rightOverlayText.textColor = .green
             rightOverlayText.text = "LIKE"
             rightOverlayText.font = rightOverlayText.font.withSize(100)
        
      
      let rightOverlay = UIView()
      rightOverlay.backgroundColor = .green
        card.footer = swiperUIView(withTitle: brand, subtitle: "Price: \(price) eur")
      card.setOverlays([.left: leftOverlay, .right: rightOverlay])
      
      return card
    }
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        return card(fromImage: cardImages[index], brand: cardBrand[index], price: cardPrice[index])
      }
      
      func numberOfCards(in cardStack: SwipeCardStack) -> Int {
          return cardImages.count
      }
}
//MARK: Leftover SwiftyGif
extension ViewController: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        logoAnimationView.isHidden = true
    }
}

//MARK: UIView Extension
extension UIView {
    
    func pinEdgesToSuperView() {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
    }
    
}
