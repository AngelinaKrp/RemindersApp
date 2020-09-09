//
//  NewReminderTableViewController.swift
//  RemindersApp
//
//  Created by Angelina on 05.08.2020.
//  Copyright © 2020 Angelina. All rights reserved.
//

import UIKit

class NewReminderTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var listToSaveLabel: UILabel!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var listForRemindersCell: UITableViewCell!
    
    // MARK: - Private properties
    let numberOfSections: Int = 2
    var selectedListToSave: String = ""
    var listToSave: MyList?
    var idOfNote: Int = 0
    
    // MARK: - Actions
    
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButton(_ sender: Any) {
        if titleLabel.text != "" {
            for each in MyList.myLists {
                if selectedListToSave == each.title {
                    if let idOfLastList = MyList.myLists[each.id].notesInList.last?.id {
                        MyList.myLists[each.id].addNote(with: idOfLastList + 1, title: titleLabel.text!, description: descriptionLabel.text!)
                        print("\(MyList.myLists[each.id].notesInList)")
                    } else {
                        MyList.myLists[each.id].addNote(with: idOfNote, title: titleLabel.text!, description: descriptionLabel.text!)
                    }
                    MyList.myLists[each.id].amountOfReminders += 1
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func choosenListToSave(segue:UIStoryboardSegue) {
        // Set selected listToSaveLabel
        if let listsToSaveTableViewController = segue.source as? ListsToSaveTableViewController, let selectedListString = listsToSaveTableViewController.selectedListString {
            
            listToSaveLabel.text = selectedListString
            selectedListToSave = selectedListString
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedListToSave == "" {
            selectedListToSave = "New"
        }
        listToSaveLabel.text = selectedListToSave
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        // Reload MyListsTableViewController
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        
        // Reload NotesTableViewController
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadReminders"), object: nil)
    }
    
    
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 && indexPath.row == 0 {
            performSegue(withIdentifier: "toMyListSeletSegue", sender: self)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 2 : 1
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let listsToSaveViewController = segue.destination as? UINavigationController else {
            print("return")
            return
        }
        let targetController = listsToSaveViewController.topViewController as! ListsToSaveTableViewController
        targetController.selectedLastListString = selectedListToSave
    }
}
