//
//  CollectionDetailsViewController.swift
//  ShopifyInternApp
//
//  Created by Rinni Swift on 3/15/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class CollectionDetailsViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionTitle: UILabel!
    
    // MARK: Variables
    var stringOfIds: String = ""
    let networkService = NetworkService()
    var items: [CollectionInfo] = []
    var collectionTitleString: String = ""
    
    // MARK: Actions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NetworkService.request(router: Router.getProductInfo(productId: stringOfIds)) { (result: [String : [CollectionInfo]]) in
            self.items = result["products"]!
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
        }
        collectionTitle.text = collectionTitleString
        flowLayout()
    }
    
    func flowLayout() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width = view.frame.size.width - 20
        let height = (view.frame.size.width - 20) / 3
        layout.itemSize = CGSize(width: width, height: height)
    }
    
    func stringToImage(string: String) -> UIImage? {
        let url = URL(string: string)
        let data = try? Data(contentsOf: url!)
        if data == nil {
            print("image data is nil")
            return nil
        } else {
            let image = UIImage(data: data!)
            if image == nil {
                return nil
            } else {
                return image!
            }
        }
    }
}

extension CollectionDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! CollectionDetailsCollectionViewCell
        
        let product = items[indexPath.item]
        cell.productTitleLabel.text = product.title
        
        var string = ""
        for item in product.variants {
            string += ("product: \(item.title)" + " quantity: \(item.inventoryQuantity)\n")
        }
        cell.variantsInfoTextView.text = string
        
        cell.imageView.image = self.stringToImage(string: product.image.path)
        return cell
    }
}
