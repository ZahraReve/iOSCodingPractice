//
//  SeeListTableViewController.swift
//  TableView
//
//  Created by User on 8/5/23.
//

import UIKit

// make a Delegate of this class
protocol SeeListTvcDelegate : AnyObject {
    func fetchFlag(_ flag: String?)
}


class SeeListTableViewController: UITableViewController {

    weak var delegate : SeeListTvcDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
             
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let countryname = ["Australia".localized(), "Bangladesh".localized(), "France".localized(), "Kenya".localized(), "Slovakia".localized()]
        cell.textLabel?.text = countryname[indexPath.row]
                
        return cell
    }
    
    // For selecting each table row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCell = tableView.cellForRow(at: indexPath)
        let selectedText = selectedCell?.textLabel?.text
        //print(selectedText!) //force unwrapping the string
        
        // call Delegate
        delegate?.fetchFlag(selectedText!)
        
        //To DISMISS this child view, instead of POP
        //dismiss(animated: true, completion: nil)
        
        // To POP the new view, instead of DISMISS
        navigationController?.popViewController(animated: true)
    }

}
