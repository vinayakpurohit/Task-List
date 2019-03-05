//
//  ViewController.swift
//  Task List
//
//  Created by Vinayak Purohit on 04/03/19.
//  Copyright © 2019 Vinayak Purohit. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let item1 = Item()
        item1.title = "Jai baba ri"
        itemArray.append(item1)
        
        let item2 = Item()
        item2.title = "hello"
        itemArray.append(item2)
        
        
        let item3 = Item()
        item3.title = "world"
        itemArray.append(item3)
        
        if let items = defaults.array(forKey: "TodoListItemArray") as? [Item]{
            itemArray = items
       }
    }
    
    
    //MARK - Tableview datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        
        //Ternary Operator
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        
        return cell
    }
    
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    // MARK - Add new add items
    @IBAction func addItemButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add new Tasky Item", message: "", preferredStyle:.alert)
        
        var newItem = UITextField()
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the Add Item button on UiAlert
            
            let itemHere = Item()
            itemHere.title = newItem.text!
            
            self.itemArray.append(itemHere)
            
            self.defaults.set(self.itemArray, forKey: "TodoListItemArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            newItem = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

