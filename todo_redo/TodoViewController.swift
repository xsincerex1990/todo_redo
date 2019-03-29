//
//  ViewController.swift
//  todo_redo
//
//  Created by Joel alexis on 3/28/19.
//  Copyright © 2019 Joel alexis. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {
    let itemArray = ["ready", "set", "go"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //    MARK: DATA SOURCE
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //    MARK: TABLEVIEW DELEGATE METHODS
    //    Using all the help we can get from xcode
    //    in this case using these methods we do not have to set no IBAction, no "delegate = self" property.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

