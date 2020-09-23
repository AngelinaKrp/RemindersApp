//
//  ListsToSaveTableViewController.swift
//  RemindersApp
//
//  Created by Angelina on 05.08.2020.
//  Copyright © 2020 Angelina. All rights reserved.
//

import UIKit

final class ListsToSaveTableViewController: UITableViewController {
    
    // MARK: - Private properties
    
    private var lists: [String]! = ["New",
                                    "Swift HW",
                                    "Education",
                                    "Podcasts",
                                    "Books"]
    private var selectedListIndex: Int? = nil
    private var selectedList: MyList?
    private var numberOfSections: Int = 1
    
    // MARK: - Private properties
    
    var selectedListString: String? = nil
    var selectedLastListString: String? = nil
    
    // MARK: - Actions
    
    @IBAction func returnButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSelectedListIndex()
    }
    
    // MARK: - Private methods
    
    private func setSelectedListIndex() {
        MyList.defaultLists.forEach { list in
            if list.title == selectedLastListString {
                selectedListIndex = list.id
                return
            }
        }
    }
    
    private func setImageView(indexPathRow: Int) -> (UIImage?, UIColor) {
        
        let image: UIImage
        let color: UIColor
        
        switch indexPathRow {
        case 0:
            image = UIImage(systemName: "list.bullet")!
            color = UIColor.red
        case 1:
            image = UIImage(systemName: "desktopcomputer")!
            color = UIColor.orange
        case 2:
            image = UIImage(systemName: "square.and.pencil")!
            color = UIColor.purple
        case 3:
            image = UIImage(systemName: "music.note")!
            color = UIColor.blue
        case 4:
            image = UIImage(systemName: "book")!
            color = UIColor.green
        default:
            image = UIImage(systemName: "list.bullet")!
            color = UIColor.black
        }
        return (image, color)
        
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
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        cell.textLabel?.text = lists[indexPath.row]
        
        ///Think with enum!!
        (cell.imageView!.image, cell.imageView!.tintColor) = setImageView(indexPathRow: indexPath.row)
        
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
