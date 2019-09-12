//
//  ViewController.swift
//  ToDoey
//
//  Created by Jane Walker on 07/09/2019.
//  Copyright © 2019 Jane Walker. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    //var itemArray = ["Ring Sam", "Buy eggs", "Email dad"]
    var itemArray = [Item]()
    
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Ring Sam"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy eggs"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Email dad"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
            itemArray = items
        }
    }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title

        // ternary operator
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true{
//                        cell.accessoryType = .checkmark
//                    } else {
//                        cell.accessoryType = .none
//                    }
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //   print(itemArray[indexPath.row])
        
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//                tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//
        
//next line replaces the following 5 lines
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

//        if itemArray[indexPath.row].done == false{
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }

        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Mark - add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add new ToDoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //what will happen when user clicks Add item button on UIAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
           // self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

