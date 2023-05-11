//  Use delegate to get value from a given table and show it in another view

//  ProfileViewController.swift
//  TableView
//
//  Created by User on 7/5/23.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController , SeeListTvcDelegate {
    
    // Definition of the Delegate function
    func fetchFlag(_ flag: String?) {
        
        // Handle the selected item by showing name and flag
        //print(flag!)
        let flagName = flag!
        label.text = flagName.localized()
        let flagPic = flagName.prefix(3).lowercased()
        image.image = UIImage(named: flagPic)
        
        // To POP the new view, instead of DISMISS
        //navigationController?.popViewController(animated: true)
    }
    
    
    // Screen
    private let screen: UIView = {
        let screen = UIView()
        screen.translatesAutoresizingMaskIntoConstraints = false
        screen.backgroundColor = .white
        
        return screen
    }()
    
    // Button
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("Select a Country", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    // COUNTRY Label
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //la.backgroundColor = .blue
        //label.text = " A "
        label.textColor = .black
        
        return label
    }()

    // Country Image
    private let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode  = .scaleAspectFill
        image.clipsToBounds = true
        //image.image = UIImage(named: "aus")
        
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(screen)
        screen.addSubview(button)
        screen.addSubview(label)
        screen.addSubview(image)
        
        addConstraints()
        createObservers()
        
        
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 45))
        navbar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        navigationItem.title = "Profile"

    }
    
    // ------------------------------------- Notification -----------------------------------------
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    func createObservers(){
      
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileViewController.updateLanguage(_:)), name: bt, object: nil)
    }
    
    @objc func updateLanguage(_ notification:Notification){
        button.setTitle(button.getText().localized(), for: .normal)
        navigationItem.title = navigationItem.title?.localized()
      
    }
    // ------------------------------------- Notification -----------------------------------------
   

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        button.addTarget(self, action: #selector(getData) , for: .touchUpInside)
    }
    
    @objc func getData(sender: UIButton){
        
        //To PRESENT the new view, instead of PUSH
        
        //        let childViewController = SeeListTableViewController()
        //        childViewController.delegate = self
        //        present(childViewController, animated: true, completion: nil)
        
        
        //To PUSH the new view, instead of PRESENT
        
        let childViewController = SeeListTableViewController()
        childViewController.delegate = self
        navigationController?.pushViewController(childViewController, animated: true)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        guard
            let nav = segue.destination as? UINavigationController,
            let seeListObj = nav.topViewController as? SeeListTableViewController
        else { return }
        seeListObj.delegate = self
    }
    
    private func addConstraints() {
        
        var cons = [NSLayoutConstraint]()
        
        
        // we will add the entire safe area as Screen
        cons.append(screen.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        cons.append(screen.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        cons.append(screen.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        cons.append(screen.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        
        
        // Add the BUTTON
        cons.append(button.widthAnchor.constraint(equalTo: screen.widthAnchor, multiplier: 0.4))
        cons.append(button.heightAnchor.constraint(equalTo: screen.heightAnchor, multiplier: 0.07))
        //cons.append(button.centerYAnchor.constraint(equalTo: screen.centerYAnchor)) //centers HORIZONTALLY = Y
        cons.append(button.centerXAnchor.constraint(equalTo: screen.centerXAnchor)) //centers VERTICALLY = X
        cons.append(button.topAnchor.constraint(equalTo: screen.topAnchor, constant: 20))
        
        
        // Add the LABEL
        cons.append(label.widthAnchor.constraint(equalTo: screen.widthAnchor, multiplier: 0.6))
        cons.append(label.heightAnchor.constraint(equalTo: screen.heightAnchor, multiplier: 0.07))
        //cons.append(button.centerYAnchor.constraint(equalTo: screen.centerYAnchor)) //centers HORIZONTALLY = Y
        cons.append(label.centerXAnchor.constraint(equalTo: screen.centerXAnchor)) //centers VERTICALLY = X
        //cons.append(label.topAnchor.constraint(equalTo: screen.topAnchor, constant: 100))
        cons.append(label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 100))
        
        
        // Add the IMAGE
        cons.append(image.widthAnchor.constraint(equalTo: screen.widthAnchor, multiplier: 0.6))
        cons.append(image.heightAnchor.constraint(equalTo: screen.widthAnchor, multiplier: 0.4))
        //cons.append(button.centerYAnchor.constraint(equalTo: screen.centerYAnchor)) //centers HORIZONTALLY = Y
        cons.append(image.centerXAnchor.constraint(equalTo: screen.centerXAnchor)) //centers VERTICALLY = X
        //cons.append(.topAnchor.constraint(equalTo: screen.topAnchor, constant: 100))
        cons.append(image.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 100))
        
        // Activate
        NSLayoutConstraint.activate(cons)
    }
    
    
    
}


