//
//  ViewController.swift
//  Todoey
//
//  Created by МакЛарен on 3/20/19.
//  Copyright © 2019 Asset Ryskul. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    
    var itemArray = [Item]()
    var defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
        
    }
    
    //MARK: - tableView Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done == true ? .checkmark : .none
        return cell
    }
    
    //MARK: - tableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add new item button
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks Add Item button on our UIAlert
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField =  alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    


}

