//
//  NewReminderTableViewController.swift
//  RemindersApp
//
//  Created by Angelina on 05.08.2020.
//  Copyright © 2020 Angelina. All rights reserved.
//

import UIKit

final class NewReminderTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var listToSaveLabel: UILabel!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var listForRemindersCell: UITableViewCell!
    
    // MARK: - Private properties
    
    private let numberOfSections: Int = 2
    private var listToSave: MyList?
    private var idOfNote: Int = 0
    let setListSection: Int = 2
    let setListRow: Int = 0
    
    // MARK: - Properties
    
    var selectedListToSave: String = ""
    
    // MARK: - Actions
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButton(_ sender: Any) {
        if titleLabel.text != "" {
            for each in MyList.defaultLists {
                if selectedListToSave == each.title {
                    if let idOfLastList = MyList.defaultLists[each.id].notes.last?.id {
                        MyList.defaultLists[each.id].addNote(with: idOfLastList + 1, title: titleLabel.text ?? "", description: descriptionLabel.text ?? "")
                        print("\(MyList.defaultLists[each.id].notes)")
                    } else {
                        MyList.defaultLists[each.id].addNote(with: idOfNote, title: titleLabel.text ?? "", description: descriptionLabel.text ?? "")
                    }
                    MyList.defaultLists[each.id].remindersCount += 1
                }
            }
        }
        dismiss(animated: true)
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
        
        if selectedListToSave.isEmpty {
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
    
    // MARK: - Private methods
    
    private func getNunberOfRows(section: Int) -> Int {
        section == 0 ? 2 : 1
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == setListSection && indexPath.row == setListRow {
            performSegue(withIdentifier: "toMyListSeletSegue", sender: self)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getNunberOfRows(section: section)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let listsToSaveViewController = segue.destination as? UINavigationController else {
            return
        }
        let targetController = listsToSaveViewController.topViewController as! ListsToSaveTableViewController
        targetController.selectedLastListString = selectedListToSave
    }
}
