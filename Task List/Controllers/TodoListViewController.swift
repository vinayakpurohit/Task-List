//
//  ViewController.swift
//  Task List
//
//  Created by Vinayak Purohit on 04/03/19.
//  Copyright © 2019 Vinayak Purohit. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController{

    var todoItems : Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    
    }
    
    
    //MARK - Tableview datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row]{
            cell.textLabel?.text = item.title

            //Ternary Operator
            // value = condition ? valueIfTrue : valueIfFalse
            
            cell.accessoryType = item.done ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No items in ,\(selectedCategory?.name ?? "this category")"
        }
        
       
        
        
        
        return cell
    }
    
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
        
        
        if let item = todoItems?[indexPath.row]{
            do{
                try realm.write {
              //      realm.delete(item) used for deleting object in realm
                    item.done = !item.done
                }
            }catch{
                print("Error updating done status,\(error)")
            }
        }
        
        tableView.reloadData()
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        
//       todoItems[indexPath.row].done = !todoItems[indexPath.row].done
//
//        saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    // MARK - Add new add items
    @IBAction func addItemButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add new Tasky Item", message: "", preferredStyle:.alert)
        
        var newItem = UITextField()
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the Add Item button on UiAlert
            
        
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write {
                        let itemHere = Item()
                        itemHere.title = newItem.text!
                        itemHere.dateCreated = Date()
                        currentCategory.items.append(itemHere)
                    }
                }catch{
                    print("Error saving new items,\(error)")
                }
            }

            self.tableView.reloadData()
    
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            newItem = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
//MARK - Model Manipulation Methods
    
    
//    func saveData(){
//
//        do{
//            try context.save()
//        }catch{
//            print("Error saving context, \(error)")
//        }
//        // self.defaults.set(self.itemArray, forKey: "TodoListItemArray")
//
//        self.tableView.reloadData()
//    }
    
    
    func loadItems(){

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    
    
    
}


extension TodoListViewController : UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }



    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }else{
            todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchText).sorted(byKeyPath: "dateCreated", ascending: true)
            tableView.reloadData()
        }
    }

}



