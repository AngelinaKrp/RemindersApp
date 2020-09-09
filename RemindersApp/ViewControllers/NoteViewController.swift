//
//  NoteViewController.swift
//  RemindersApp
//
//  Created by Angelina on 05.08.2020.
//  Copyright © 2020 Angelina. All rights reserved.
//

import UIKit

final class NoteViewController: UIViewController {
    
    // MARK: - Public properties
    
    var noteModel: Note?
    
    // MARK: - Outlets
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = noteModel?.title
        descriptionLabel.text = noteModel?.description
    }
}
