//
//  SearchTableViewController.swift
//  RemindersApp
//
//  Created by Angelina on 12.08.2020.
//  Copyright © 2020 Angelina. All rights reserved.
//

import UIKit

final class SearchTableViewController: UITableViewController {
    
    // MARK: - Private properties
    
    private var results: [MyList] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var lists: [String]!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: CGRect.zero, style: .grouped)
        self.view.backgroundColor = UIColor.white
        tableView.register(UINib(nibName: "SearchTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: SearchTableViewCell.reusableId)
    }
    
    // MARK: - Public methods
    
    func setNew(results: [MyList]) {
        self.results = results.filter { $0.notesInList.count != 0 }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        results.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results[section].notesInList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.configuree(with: results[indexPath.section], model: results[indexPath.section].notesInList[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label: UILabel = UILabel()
        label.text = results[section].title
        
        switch results[section].id {
        case 0:
            label.textColor = UIColor.red
        case 1:
            label.textColor = UIColor.orange
        case 2:
            label.textColor = UIColor.purple
        case 3:
            label.textColor = UIColor.blue
        case 4:
            label.textColor = UIColor.green
        default:
            label.textColor = UIColor.black
        }
        label.font = UIFont(name: "ChalkboardSE-Bold", size: 35)
        return label
    }
}
