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
    private enum MyColor: Int {
        case red = 0
        case orange = 1
        case purple = 2
        case blue = 3
        case green = 4

        func toUIColor() -> UIColor {
            switch self {
            case .red:
                return UIColor.red
            case .orange:
                return UIColor.orange
            case .purple:
                return UIColor.purple
            case .blue:
                return UIColor.blue
            case .green:
                return UIColor.green
            }
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
        self.results = results.filter { $0.notes.count != 0 }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        results.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results[section].notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.configure(with: results[indexPath.section], model: results[indexPath.section].notes[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label: UILabel = UILabel()
        label.text = results[section].title
        label.textColor = MyColor(rawValue: results[section].id)?.toUIColor()
        label.font = UIFont(name: "ChalkboardSE-Bold", size: 35)
        return label
    }
}
