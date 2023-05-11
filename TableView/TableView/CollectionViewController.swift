//
//  CollectionViewController.swift
//  TableView
//
//  Created by User on 10/5/23.
//

import Foundation
import UIKit

// make a Delegate of this class
protocol CVCDelegate : AnyObject {
    func getCol(_ col: String?)
}


class CollectionViewController : UIViewController , SettingsDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private var isScreenOrientationPortrait = true
    private var portraitWidth: CGFloat =  300.0
    private var portraitHeight: CGFloat = 600.0

    
    func getNameofNextPage(_ name: String?) -> String {
        print("In CVC")
        print(name!)
        navigationItem.title = name
        return name!
    }
    
    var cvc : UICollectionView?
    var screen : UIView? = nil
    weak var delegate : CVCDelegate?
    
    
//    private let navBar: UINavigationBar = {
//        let navbar = UINavigationBar()
//        return navbar
//    }()
    
    
    // ------------------------------------- Notification -----------------------------------------
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    func createObservers(){
      
        NotificationCenter.default.addObserver(self, selector: #selector(LanguageViewController.updateLanguage(_:)), name: bt, object: nil)
        
    }
    
    @objc func updateLanguage(_ notification:Notification){
        navigationItem.title = navigationItem.title?.localized()
      
    }
    // ------------------------------------- Notification -----------------------------------------
//    private let navbar : UINavigationBar = {
//        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: , height: 45))
//        return navbar
//    }()
    
    //let viewWidth = view.frame.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screen = UIView()
        screen?.backgroundColor = .white
        
        portraitWidth = view.frame.size.width //?? 300
        portraitHeight = view.frame.size.height //?? 600
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        //layout.itemSize = CGSize(width: 125, height: 125)
        
        cvc = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        //    cvc.collectionView(self, layout, collectionViewLayout:layout, sizeForItemAt indexPath: IndexPath)

        // default collectionViewCell
        //cvc?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CVCcell")
        // Custom collectionViewCell
        cvc?.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: "GalleryCell")
        
        cvc?.backgroundColor = UIColor.white

        view.addSubview(cvc ?? UICollectionView())
        
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 45))
        navbar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
                
        let settingdelegate = SettingsViewController()
        settingdelegate.delegate = self
        //self.view = screen
        
        //navigationItem.title = settingdelegate.delegate.ge
        cvc?.dataSource = self
        cvc?.delegate = self
        
        createObservers()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            isScreenOrientationPortrait = false
            cvc?.frame.size = CGSize(width: portraitHeight, height: portraitWidth)
        }else if UIDevice.current.orientation.isPortrait {
            print("Portrait")
            isScreenOrientationPortrait = true
            cvc?.frame.size = CGSize(width: portraitWidth, height: portraitHeight)
        } else if UIDevice.current.orientation.isFlat {
            print("Flat")
            isScreenOrientationPortrait = false
            cvc?.frame.size = CGSize(width: portraitHeight, height: portraitWidth)
        }
        // Trigger layout update
        cvc?.collectionViewLayout.invalidateLayout()
            
        // Reload the collection view
        //cvc?.reloadData()
        
        //Reload the view Screen size
        //screen?.layoutIfNeeded()

                
//            coordinator.animate(alongsideTransition: { _ in
//                // Perform any UI updates or layout changes here
//
//                self.updateUIForRotation()
//            }, completion: nil)
        }

        private func updateUIForRotation() {
            // Update your UI based on the new device orientation
            // This can involve modifying constraints, adjusting frames, reloading data, etc.
        }
}

extension CollectionViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 67
    }
    
    // for default cell
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCcell", for: indexPath)
//        myCell.backgroundColor = UIColor.blue
//        return myCell
//    }
    
    // for custom cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as? GalleryCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = UIColor.cyan
        
        let img_name = ["cat_black", "cat_brown", "cat_gray", "cat_green", "cat_white","aus","fra","ken","slo","ban"]
                
        cell.imageView.image = (UIImage(named: img_name[indexPath.row % 10]))
                
        
        return cell //as! GalleryCollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (isScreenOrientationPortrait){
            return CGSize(width: view.frame.size.width / 3 - 3 , height: view.frame.size.width / 3 - 3)
        } else {
            return CGSize(width: view.frame.size.height / 3 - 3 , height: view.frame.size.height / 3 - 3)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
