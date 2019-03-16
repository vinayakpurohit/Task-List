//
//  CategoryViewController.swift
//  Task List
//
//  Created by Vinayak Purohit on 11/03/19.
//  Copyright © 2019 Vinayak Purohit. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryArray : Results<Category>?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()

    }

    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories added yet"
        
        return cell
        
    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            
            destinationVC.selectedCategory = self.categoryArray?[indexPath.row]
            
        }
    }
    //MARK: - Data Manipulation Methods
    
    func save(category: Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("Error saving realm category,\(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadData(){
        
        categoryArray = realm.objects(Category.self)
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//
//        do{
//            categoryArray = try context.fetch(request)
//        }catch{
//            print("Error fetching context,\(error)")
//        }
        
        tableView.reloadData()
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        var newTextField = UITextField()
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category()
            
            newCategory.name = newTextField.text!
            
            self.save(category: newCategory)
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            newTextField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
}
