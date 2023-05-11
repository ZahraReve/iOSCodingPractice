//
//  GalleryCollectionViewController.swift
//  TableView
//
//  Created by User on 11/5/23.
//

import Foundation
import UIKit

struct Item{
    var imageName: String
}

class GalleryCollectionViewController: UIViewController {
    
    var collectionView : UICollectionView!
    
    var items: [Item] = [Item(imageName: "cat_black"),
                         Item(imageName: "cat_brown"),
                         Item(imageName: "cat_gray"),
                         Item(imageName: "cat_green"),
                         Item(imageName: "cat_white")
    ]
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    let cellIdentifier = "GalleryCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setUpGallery(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension GalleryCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! GalleryCollectionViewCell
        
        return cell
    }
    
    
    
    
}
