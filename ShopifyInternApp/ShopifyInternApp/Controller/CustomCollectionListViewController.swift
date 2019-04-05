//
//  CustomCollectionListViewController.swift
//  ShopifyInternApp
//
//  Created by Rinni Swift on 3/15/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class CustomCollectionListViewController: UIViewController, UICollectionViewDelegateFlowLayout {

    // MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Variables
    var sources: [String: [CollectionItem]] = [:] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkService.request(router: .getSources) { (result: [String : [CollectionItem]]) in
            self.sources = result
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
        }
        flowLayout()
    }
    
    // MARK: Functions
    func flowLayout() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width = (view.frame.size.width - 20)
        let height = (view.frame.size.width - 20) / 3
        layout.itemSize = CGSize(width: width, height: height)
    }
    
}

extension CustomCollectionListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (sources["custom_collections"]?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let array = sources["custom_collections"]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionListCollectionViewCell
        cell.collectionTitleLabel.text = array![indexPath.item].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let array = sources["custom_collections"]
        let id = String(array![indexPath.item].id)
        
        NetworkService.request(router: Router.getProductIds(collectionId: id)) { (result: [String : [CollectionItemId]]) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let collectionDetailsViewController = storyboard.instantiateViewController(withIdentifier: "collectionDetailsVC") as! CollectionDetailsViewController
            
            let ids = result["collects"]!
            let stringId = String(ids.reduce("") { $0 + String($1.productId) + ","}).dropLast()
            
            collectionDetailsViewController.collectionTitleString = array![indexPath.item].title
            collectionDetailsViewController.stringOfIds = String(stringId)
            self.present(collectionDetailsViewController, animated: true, completion: nil)
        }
    }
}
