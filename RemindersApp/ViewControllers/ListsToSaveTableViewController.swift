//
//  ListsToSaveTableViewController.swift
//  RemindersApp
//
//  Created by Angelina on 05.08.2020.
//  Copyright © 2020 Angelina. All rights reserved.
//

import UIKit

class ListsToSaveTableViewController: UITableViewController {
    
    // MARK: - Private properties
    
    var lists: [String]!
    var selectedListString: String? = nil
    var selectedListIndex: Int? = nil
    var selectedLastListString: String? = nil
    private var selectedList: MyList?
    private var numberOfSections: Int = 1
    
    // MARK: - Actions
    
    @IBAction func returnButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lists = ["New",
                 "Swift HW",
                 "Education",
                 "Podcasts",
                 "Books"]
        
        MyList.myLists.forEach { list in
            if list.title == selectedLastListString {
                selectedListIndex = list.id
                return
            }
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Other row is selected - need to deselect it
        if let index = selectedListIndex {
            let cell = tableView.cellForRow(at: NSIndexPath(row: index, section: 0) as IndexPath)
            cell?.accessoryType = .none
        }
        
        selectedListIndex = indexPath.row
        selectedListString = lists[indexPath.row]
        
        // Update the checkmark for the current row
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    @IBAction func selectedList(segue:UIStoryboardSegue) {
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        cell.textLabel?.text = lists[indexPath.row]
        
        if indexPath.row == 0 {
            cell.imageView!.image = UIImage(systemName: "list.bullet")
            cell.imageView!.tintColor = UIColor.red
        }
        if indexPath.row == 1 {
            cell.imageView!.image = UIImage(systemName: "desktopcomputer")
            cell.imageView!.tintColor = UIColor.orange
        }
        if indexPath.row == 2 {
            cell.imageView!.image = UIImage(systemName: "square.and.pencil")
            cell.imageView!.tintColor = UIColor.purple
        }
        if indexPath.row == 3 {
            cell.imageView!.image = UIImage(systemName: "music.note")
            cell.imageView!.tintColor = UIColor.blue
        }
        if indexPath.row == 4 {
            cell.imageView!.image = UIImage(systemName: "book")
            cell.imageView!.tintColor = UIColor.green
        }
        
        if indexPath.row == selectedListIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SaveSelectedList" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                selectedListIndex = indexPath?.row
                if let index = selectedListIndex {
                    selectedListString = lists[index]
                }
            }
        }
    }
}
