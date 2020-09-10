//
//  NotesTableViewController.swift
//  RemindersApp
//
//  Created by Angelina on 05.08.2020.
//  Copyright © 2020 Angelina. All rights reserved.
//


import UIKit

final class NotesTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var newReminderButton: UIBarButtonItem!
    
    // MARK: - Private properties
    
    private var selectedNote: Note?
    private let numberOfSection = 1
    var selectedList: MyList?
    private var notes: [Note] = [] {
        didSet {
            /// Observe notes changes in `didSet` block
            refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func newReminerTapped(_ sender: Any) {
        performSegue(withIdentifier: "newReminderSeletedSegue", sender: self)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(getNotes), name: NSNotification.Name(rawValue: "loadReminders"), object: nil)
        
        navigationItem.title = selectedList?.title
        
        var color: UIColor = UIColor.black
        
        switch selectedList?.id {
        case 0:
            color = UIColor.red
        case 1:
            color = UIColor.orange
        case 2:
            color = UIColor.purple
        case 3:
            color = UIColor.blue
        case 4:
            color = UIColor.green
        default:
            color = UIColor.black
        }
        
        self.navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: UIFont(name: "ChalkboardSE-Bold", size: 35)!]
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(getNotes), for: .valueChanged)
        getNotes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        // Reload MyListsTableViewController
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadMyListsTableViewController"), object: nil)
    }
    
    // MARK: - Private methods
    
    @objc
    private func getNotes() {
        self.notes = MyList.myLists[selectedList!.id].notesInList
        self.tableView.reloadData()
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNote = notes[indexPath.row]
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        numberOfSection
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
        cell.configuree(with: selectedList!, model: notes[indexPath.row])
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            if let selectList = selectedList {
                MyList.myLists[selectList.id].notesInList.remove(at: indexPath.row)
                MyList.myLists[selectList.id].amountOfReminders -= 1
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let newReminderViewController = segue.destination as? UINavigationController else {
            return
        }
        let targetController = newReminderViewController.topViewController as! NewReminderTableViewController
        // Pass the selected object to the new view controller.
        targetController.selectedListToSave = String(selectedList!.title)
    }
}
