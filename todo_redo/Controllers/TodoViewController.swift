//
//  ViewController.swift
//  todo_redo
//
//  Created by Joel alexis on 3/28/19.
//  Copyright © 2019 Joel alexis. All rights reserved.
//

import UIKit
import CoreData


class TodoViewController: UITableViewController {
    var itemArray = [Item]()
//    This constant goes into the app delegate, grabs the persistent container and grab a reference to the context that sits in the persistenContainer 
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
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
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
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
    
    func saveData() {

        
        
        do {
             try context.save()
        } catch {
            print("error encoding item array, \(error)")
        }
        tableView.reloadData()
        
    }

    
    func loadItems() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray =  try context.fetch(request)
        } catch {
            print("Error fetching context, \(error)")
        }
    }
    

}

