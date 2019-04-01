//
//  ViewController.swift
//  todo_redo
//
//  Created by Joel alexis on 3/28/19.
//  Copyright © 2019 Joel alexis. All rights reserved.
//

import UIKit


class TodoViewController: UITableViewController {
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
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
        saveData()
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
            self.itemArray.append(newItem)
            self.saveData()
        })
//        add a textfield to UIALERT
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //    MARK: Data manipulation
    
    //this method encodes from type Item to Plist
    func saveData() {
        //createencoder
        let encoder = PropertyListEncoder()
        
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("error encoding item array, \(error)")
        }
        tableView.reloadData()
        
    }
    //method that decodes the contents od dataFilePath to type Item
    func loadItems() {
        // try? turns the result of the data() method intoan optional
        if let data = try? Data(contentsOf: dataFilePath!) {
            //create decoder
            let decoder = PropertyListDecoder()
            
//            decode is the method to decode encoded data...you must specify its data type
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding \(error)")
            }
        }
    }
    

}

