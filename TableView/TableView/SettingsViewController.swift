//  For API. Get a json file from given URL and set to the label, every time button is clicked, new joke (JSON) is loaded

//  SettingsViewController.swift
//  TableView
//
//  Created by User on 7/5/23.
//

import Foundation
import UIKit

// make a Delegate of this class
protocol SettingsDelegate : AnyObject {
    func getNameofNextPage(_ name: String?) -> String
}


class SettingsViewController: UIViewController, CVCDelegate
{
    weak var delegate : SettingsDelegate?
    
    func getCol(_ col: String?) {
        print("Collection View Delegate")
        
    }
    
    private let label : UILabel =
    {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.text = "_____________________________"

        return label
    }()
    
    private let button : SubclassedUIButton =
    {
        let button = SubclassedUIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        //var urlString: String?
        
        button.setTitle("New joke", for: .normal)
        button.urlString = "https://official-joke-api.appspot.com/random_joke"
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        
        return button //as! SubclassedUIButton
    }()
    
    private let gallery : UIButton =
    {
        let button = UIButton(frame: CGRect(x: 50, y: 100, width: 70, height: 35))
        //var urlString: String?
        
        button.setTitle("Gallery", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.red, for: .selected)
        
        return button //as! SubclassedUIButton
    }()
    
//    private let navBar: UINavigationBar = {
//
//
//
//        return navbar
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 45))
        
        // to go to gallery
        let rightButton = UIBarButtonItem(title: "Gallery", style: .plain , target: self, action: #selector(newPage))
        navigationItem.rightBarButtonItems = [rightButton]
        // Set the text color for the navigation items
        navbar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        navigationItem.title = "Settings"
        
        view.addSubview(button)
        view.addSubview(label)
        view.addSubview(navbar)
        
        //view.addSubview(gallery)
        
       // to get new joke
        button.addTarget(self, action: #selector(getData) , for: .touchUpInside)
        
        //for notification
        createObservers()
    }
    
    
    // ------------------------------------- Notification -----------------------------------------
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    func createObservers(){
      
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsViewController.updateLanguage(_:)), name: bt, object: nil)
    }
    
    @objc func updateLanguage(_ notification:Notification){
        button.setTitle(button.getText().localized(), for: .normal)
        navigationItem.title = navigationItem.title?.localized()
        navigationItem.rightBarButtonItem?.title =  navigationItem.rightBarButtonItem?.title?.localized()
    }
    // ------------------------------------- Notification -----------------------------------------
   
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.center = view.center
        //label.frame = view.center
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        let lw = Int(label.sizeThatFits(view.frame.size).width)
//        let lh = Int(label.sizeThatFits(view.frame.size).height)
        
        label.frame = CGRect(x: 15, y: 200, width:350, height:400 )
        //label.sizeToFit()
        
        label.font = UIFont(name: "Helvetica Neue Light", size: 30)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.sizeToFit()
    }
    
    
//
    
    @objc func newPage(){
        
        print("inside newPage fn")
        //To PUSH the new view, instead of PRESENT
        
        //let childViewController = GalleryViewController()
        let childViewController = CollectionViewController()
        //childViewController.delegate = self
        navigationController?.pushViewController(childViewController, animated: true)
        
        // send the name of the next page so the language is consistent
        // call Delegate
        delegate?.getNameofNextPage(navigationItem.rightBarButtonItem?.title!)
        //print(navigationItem.rightBarButtonItem?.title)
    }
    
    
    //private func getData(from url: String){
    //@objc func getData(sender: UIButton, url: String){
    @objc func getData(sender: SubclassedUIButton){
        
        print("Inside getData fn")
        
        let url = sender.urlString!
        
        URLSession.shared.dataTask(with: URL(string: url)! , completionHandler: {data, response, error in
            guard let data = data, error == nil else{
                print("something went wrong")
                return
            }
            //decoding
            var result : myResult?
            do {
                result = try JSONDecoder().decode(myResult.self, from: data)
            }
            catch {
                print("failed to convert \(error.localizedDescription)")
            }
            guard let json = result else {
                return
            }
            // This function allows the code to be executed in the main thread
            DispatchQueue.main.async {
                self.label.text = json.setup + "\n" + json.punchline
            }
//            print(json.setup)
//            print(json.punchline)
        }).resume()
    }
}


struct myResult : Codable{
    let type : String
    let setup : String
    let punchline : String
    let id : Int
}
