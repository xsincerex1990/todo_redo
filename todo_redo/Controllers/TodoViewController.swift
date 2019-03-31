//
//  ViewController.swift
//  todo_redo
//
//  Created by Joel alexis on 3/28/19.
//  Copyright © 2019 Joel alexis. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {
    let defaults = UserDefaults.standard
    var itemArray = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find larry"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Find larry"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "hustle"
        itemArray.append(newItem2)

        //retain data from defaults if terminated
//        if our array is empty our app will crash so lets do if let to check if its empty
        if let items = UserDefaults.standard.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }
    //    MARK: DATA SOURCE
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        let item = itemArray[indexPath.row]
        // value = condition ? valueiftrue : valueiffalse
        cell.accessoryType = item.done ? .checkmark : .none

        
        return cell
    }
    
    //    MARK: TABLEVIEW DELEGATE METHODS
    //    Using all the help we can get from xcode
    //    in this case using these methods we do not have to set no IBAction, no "delegate = self" property.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //    MARK: ADD NEW ITEMS
    
    @IBAction func addButtonPressed(_ sender: Any) {
        //this alert will pop up when add button gets pressed
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new to-do item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default, handler: { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            //what happends when the user clicks add on UI ALERT
            //self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
            
        })
//        add a textfield to UIALERT
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    

}

