//
//  LanguageViewController.swift
//  TableView
//
//  Created by User on 9/5/23.
//

import Foundation
import UIKit

class LanguageViewController : UIViewController {

    private var lastSelectedLanguage = en
    
    
    ////  Add View
    private let view1: UIView = {
        let view1 = UIView()
        view1.translatesAutoresizingMaskIntoConstraints = false
        return view1
    }()
    
    /// Label to check language
    private let langLabel: UILabel = {
        let label = UILabel()
        //label.text = "Hello"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// English
    private let _switch : UIButton = {
        let _switch  = UIButton()
        _switch.backgroundColor = .darkGray
        _switch.setTitle("English",for: .normal)
        _switch.translatesAutoresizingMaskIntoConstraints = false
        return _switch
    }()
    
    /// Spanish
    private let label : UIButton = {
        let label  = UIButton()
        label.backgroundColor = .darkGray
        //label.font = .systemFont(ofSize: 30, weight: .bold)
        label.setTitle("Spanish",for: .normal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
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
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(view1)
        view1.addSubview(langLabel)
        view1.addSubview(_switch)
        view1.addSubview(label)
        
        // Add an action to the switch
        _switch.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        label.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 45))
        navbar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        navigationItem.title = "Language"

        addConstraints()
        createObservers()
    }
    
    //dispatchGroup.enter()
    
    @objc func buttonTapped(_ sender: UIButton) {
        let vc_static = ViewController()
        print(sender.title)
        // only when the newly selected language differs from the last one does notification gets triggered and lagnuage gets changed
        if (sender.title(for: .normal) == "English" && lastSelectedLanguage == sp){
            lastSelectedLanguage = en
            let lang = Notification.Name(rawValue: "zFerdous.buttonTap")
            NotificationCenter.default.post(name: lang, object:nil)
            
            // to handle the tabbar language as it is not loaded each time language is changed
            vc_static.updateTabbarItems()
                
        } else if(sender.getText() == "Spanish" && lastSelectedLanguage == en) {
            lastSelectedLanguage = sp
            let lang = Notification.Name(rawValue: "zFerdous.buttonTap")
            NotificationCenter.default.post(name: lang, object:nil)
            
            vc_static.updateTabbarItems()
        }
        
    }
    
    private func addConstraints() {
            
        var cons = [NSLayoutConstraint]()
        
        // Add the View1
        cons.append(view1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1))
        cons.append(view1.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5))
        cons.append(view1.centerYAnchor.constraint(equalTo:view.centerYAnchor)) //centers HORIZONTALLY = Y
        cons.append(view1.centerXAnchor.constraint(equalTo: view.centerXAnchor)) //centers VERTICALLY = X
        
        
        // Add the Lang Label
        cons.append(langLabel.widthAnchor.constraint(equalTo: view1.widthAnchor, multiplier: 0.4))
        cons.append(langLabel.heightAnchor.constraint(equalTo: view1.heightAnchor, multiplier: 0.07))
        //cons.append(button.centerYAnchor.constraint(equalTo:.centerYAnchor)) //centers HORIZONTALLY = Y
        cons.append(langLabel.centerXAnchor.constraint(equalTo: view1.centerXAnchor)) //centers VERTICALLY = X
        cons.append(langLabel.topAnchor.constraint(equalTo: view1.topAnchor, constant: 50))
        
        
        // Add the English Button
        cons.append(_switch.widthAnchor.constraint(equalTo: view1.widthAnchor, multiplier: 0.4))
        cons.append(_switch.heightAnchor.constraint(equalTo: view1.heightAnchor, multiplier: 0.07))
        cons.append(_switch.centerYAnchor.constraint(equalTo: view1.centerYAnchor)) //centers HORIZONTALLY = Y
        //cons.append(label.centerXAnchor.constraint(equalTo: screen.centerXAnchor)) //centers VERTICALLY = X
        //cons.append(_switch.bottomAnchor.constraint(equalTo: view1.bottomAnchor, constant: -1))
        cons.append(_switch.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: 30))
            
        
        // Add the Spanish button
        cons.append(label.widthAnchor.constraint(equalTo: view1.widthAnchor, multiplier: 0.4))
        cons.append(label.heightAnchor.constraint(equalTo: view1.heightAnchor, multiplier: 0.07))
        cons.append(label.centerYAnchor.constraint(equalTo: view1.centerYAnchor)) //centers HORIZONTALLY = Y
        //cons.append(label.centerXAnchor.constraint(equalTo: screen.centerXAnchor)) //centers VERTICALLY = X
        //cons.append(label.bottomAnchor.constraint(equalTo: view1.bottomAnchor, constant: -1))
        cons.append(label.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -30))
        
            // Activate
            NSLayoutConstraint.activate(cons)
        }
           
  
    
}

extension String {
    func localized() -> String {
        return NSLocalizedString(self,
                tableName:"Localizable",
                bundle: .main ,
                value: self,
                comment: self
        )
    }
}


extension UILabel {
    func getText() -> String {
        return self.text ?? ""
    }
}

extension UIButton {
    func getText() -> String {
        return self.title(for: .normal) ?? ""
    }
}

extension UIViewController {
    func getText() -> String {
        return self.title ?? ""
    }
}
