//
//  ViewController.swift
//  TableView
//
//  Created by User on 7/5/23.
//

import UIKit

let bt = Notification.Name(rawValue: "zFerdous.buttonTap")
let sp = "zFerdous.sp"
let en = "zFerdous.en"

class ViewController: UITabBarController /*observerPublish*/
{
    
    let vc1 = UINavigationController(rootViewController: ContactsViewController())
    let vc2 = UINavigationController(rootViewController: ProfileViewController())
    let vc3 = UINavigationController(rootViewController: SettingsViewController())
    let vc4 = UINavigationController(rootViewController: LanguageViewController())
    
    func updateTabbarItems(){
        vc1.title = "Contacts".localized()
        vc2.title = "Profile".localized()
        vc3.title = "Settings".localized()
        vc4.title = "Language".localized()
    }
    
    
    @objc func updateLanguage(_ notification:Notification){
        
        //for testing
        vc1.title = "Contacts".localized()
        
        let isSp = notification.object as? String
        if (isSp == sp){
            print("Spanish")
            print("Contacts".localized())
            vc1.title = "Contacts".localized()
            vc2.title = "Profile".localized()
            vc3.title = "Settings".localized()
            vc4.title = "Language".localized()
        }
        else if (isSp == en){
            print("English")
            print("Contacts".localized())
            vc1.title = "Contacts".localized()
            vc2.title = "Profile".localized()
            vc3.title = "Settings".localized()
            vc4.title = "Language".localized()
        }
        
    }
    
    //Button
    private let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 52))
        button.setTitle("On",for:.normal)
        button.backgroundColor = .blue
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // NAVbar
    private let navBar: UINavigationBar = {
        let navbar = UINavigationBar()
        return navbar
    }()
    
    //TAPBAR
    //private let tabbar : UITabBarController =
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //let tabbar = UITabBarController()
        
//        let vc1 = UINavigationController(rootViewController: ContactsViewController())
//        let vc2 = UINavigationController(rootViewController: ProfileViewController())
//        let vc3 = UINavigationController(rootViewController: SettingsViewController())
//        let vc4 = UINavigationController(rootViewController: LanguageViewController())
        

        vc1.title = "Contacts"//.localized()
        vc2.title = "Profile"//.localized()
        vc3.title = "Settings"//.localized()
        vc4.title = "Language"//.localized()

        self.setViewControllers([vc1,vc2,vc3,vc4], animated: false)
        
        guard let tabitems = self.tabBar.items else {return}
        let tab_images = ["book.circle", "person.circle", "gear.circle", "mic.badge.plus"]
        for x in 0..<tabitems.count {
            tabitems[x].image = UIImage(systemName: tab_images[x])
        }
        self.modalPresentationStyle = .fullScreen
        //self.tabBar.tintColor = .gray
        //present(tabbar, animated: true)
        
        
        //ceateObservers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //button.center = view.center
        // If we use the frame alongside constraints they will overlap with each other and this fn is called after the constraints one, so frame = view.bounds will superimpose on the constraint making it disabled
        //tableview.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //createObservers()
    }
    
//    private func addConstraints(){
//        var constraints = [NSLayoutConstraint]()
//
////         Add
//        constraints.append(tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 1))
//        constraints.append(tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -1))
//        constraints.append(tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1))
//        constraints.append(tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -1))
//
//        // Activate
//        NSLayoutConstraint.activate(constraints)
//    }
//
    
}

