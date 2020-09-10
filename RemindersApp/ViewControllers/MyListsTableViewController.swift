//
//  MyListsTableViewController.swift
//  RemindersApp
//
//  Created by Angelina on 01.08.2020.
//  Copyright © 2020 Angelina. All rights reserved.
//

import UIKit

final class MyListsTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var newLabelDetail: UILabel!
    @IBOutlet weak var swiftHwLabelDetail: UILabel!
    @IBOutlet weak var educationLabelDetail: UILabel!
    @IBOutlet weak var podcastsLabelDetail: UILabel!
    @IBOutlet weak var booksLabelDetail: UILabel!
    
    // MARK: - Private properties
    
    private let numberOfSection = 1
    private let firstSectionTitle = "My Lists"
    private var selectedListInLists: MyList?
    private var searchResultsController: SearchTableViewController?
    private var listToSave: MyList?
    private var copyOfMyLists = MyList.myLists
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set observer to update amount Of list notes
        NotificationCenter.default.addObserver(self, selector: #selector(getAmountOfMyLists), name: NSNotification.Name(rawValue: "load"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getAmountOfMyLists), name: NSNotification.Name(rawValue: "loadMyListsTableViewController"), object: nil)
        searchResultsController = SearchTableViewController()
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "AmericanTypewriter", size: 35)!]
    }
    
    // MARK: - Private methods
    
    @objc func getAmountOfMyLists() {
        newLabelDetail.text = String(MyList.myLists[0].amountOfReminders)
        swiftHwLabelDetail.text = String(MyList.myLists[1].amountOfReminders)
        educationLabelDetail.text = String(MyList.myLists[2].amountOfReminders)
        podcastsLabelDetail.text = String(MyList.myLists[3].amountOfReminders)
        booksLabelDetail.text = String(MyList.myLists[4].amountOfReminders)
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedListInLists = MyList.myLists[indexPath.row]
        performSegue(withIdentifier: "myListSeletedSegue", sender: self)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        numberOfSection
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MyList.myLists.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        firstSectionTitle
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let notesViewController = segue.destination as? NotesTableViewController else {
            return
        }
        // Pass the selected object to the new view controller.
        notesViewController.selectedList = MyList.myLists[selectedListInLists!.id]
    }
}

extension MyListsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let queryText = searchController.searchBar.text else {
            return
        }
        for i in 0...MyList.myLists.count - 1 {
            copyOfMyLists[i].notesInList.removeAll()
        }
        if !queryText.isEmpty {
            for i in 0...MyList.myLists.count - 1 {
                MyList.myLists[i].notesInList.forEach { note in
                    if note.title.lowercased().contains(queryText.lowercased()) {
                        copyOfMyLists[i].notesInList.append(note)
                    }
                }
            }
        }
        searchResultsController?.setNew(results: copyOfMyLists)
    }
}
