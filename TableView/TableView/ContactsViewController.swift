//  Show an icon a label and an arrow to right in each table cell

//  ViewController.swift
//  TableView
//
//  Created by User on 7/5/23.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  
    // TABLE
    private let tableview : UITableView =
    {
        let tableview = UITableView()
        tableview.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTVC")
        
        //for constraints
        tableview.translatesAutoresizingMaskIntoConstraints = false
        
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableview)
        //view.addSubview(tabbar)
        tableview.dataSource = self
        tableview.delegate = self
        view.backgroundColor = .white
        
        // Enable scrolling
        tableview.isScrollEnabled = true

        // Set the content size of the scroll view
        let contentHeight = tableview.contentSize.height
        let frameHeight = tableview.frame.height
        tableview.contentSize = CGSize(width: tableview.contentSize.width, height: contentHeight + frameHeight)
        
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 45))
        navbar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        navigationItem.title = "Contacts"
        
        addConstraints()
        
        createObservers()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // If we use the frame alongside constraints they will overlap with each other and this fn is called after the constraints one, so frame = view.bounds will superimpose on the constraint making it disabled
        //tableview.frame = view.bounds
    }
    
    // ------------------------------------- Notification -----------------------------------------
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    func createObservers(){
      
        NotificationCenter.default.addObserver(self, selector: #selector(ContactsViewController.updateLanguage(_:)), name: bt, object: nil)
    }
    
    @objc func updateLanguage(_ notification:Notification){
       
//        let isSp = notification.object as? String
//        if (isSp == sp){
//            print("Spanish")
            
            for row in 0..<tableview.numberOfRows(inSection: 0) {
                if let cell = tableview.cellForRow(at: IndexPath(row: row, section: 0)) as? CustomTableViewCell {
                    //print(cell._label.text! + " " + cell._label.text!.localized())
                    cell._label.text = cell._label.text?.localized()
                    
                }
            }
        navigationItem.title = navigationItem.title?.localized()
      
//
//        }
//        else if (isSp == en){
//            print("English")
//
//            for row in 0..<tableview.numberOfRows(inSection: 0) {
//                if let cell = tableview.cellForRow(at: IndexPath(row: row, section: 0)) as? CustomTableViewCell {
//                    //print(cell._label.text! + " " + cell._label.text!.localized())
//                    cell._label.text = cell._label.text?.localized()
//
//                }
//            }
//        }
    }
    // ------------------------------------- Notification -----------------------------------------
   
    private func addConstraints(){
        var constraints = [NSLayoutConstraint]()
        
//         Add
        constraints.append(tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 1))
        constraints.append(tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -1))
        constraints.append(tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1))
        constraints.append(tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -1))

        // Activate
        NSLayoutConstraint.activate(constraints)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 27
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTVC", for:indexPath) as? CustomTableViewCell else { return UITableViewCell() }

        /// TO set cell dynamically
        
        let img_name = ["house","bell","person.circle","person.circle","person.circle","star","gear"]
        let label_name = ["Home", "Notifications", "Person 1", "Person 2", "Self", "Starred", "Settings"]

        cell.configure(text: label_name[indexPath.row % 7], imgName: img_name[indexPath.row % 7])
        
        cell.selectionStyle = .default
        
        return cell
    }
}

