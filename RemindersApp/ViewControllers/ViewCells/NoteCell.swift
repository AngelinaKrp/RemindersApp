//
//  NoteCell.swift
//  RemindersApp
//
//  Created by Angelina on 05.08.2020.
//  Copyright © 2020 Angelina. All rights reserved.
//

import UIKit

final class NoteCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    // MARK: - Private properties
    
    var noteId: Int?
    var listId: Int?
    
    // MARK: - Public methods
    
    func configuree(with list: MyList, model: Note) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        listId = list.id
        noteId = model.id
        
        if model.done == true {
            checkButton.isSelected = true
            titleLabel.alpha = 0.4
            subtitleLabel.alpha = 0.4
        } else {
            checkButton.isSelected = false
            titleLabel.alpha = 1
            subtitleLabel.alpha = 1
        }
    }
    
    // Configure the view for the selected state
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkButton.addTarget(self, action: #selector(checkButtonClickes), for: .touchUpInside)
    }
    
    @objc func checkButtonClickes(sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            titleLabel.alpha = 1
            subtitleLabel.alpha = 1
            
            for noteToSaveId in 0...MyList.defaultLists[listId!].notes.count - 1 {
                if MyList.defaultLists[listId!].notes[noteToSaveId].title == titleLabel.text && MyList.defaultLists[listId!].notes[noteToSaveId].subtitle == subtitleLabel.text {
                    MyList.defaultLists[listId!].notes[noteToSaveId].done = false
                }
            }
        } else {
            sender.isSelected = true
            titleLabel.alpha = 0.4
            subtitleLabel.alpha = 0.4
            
            for noteToSaveId in 0...MyList.defaultLists[listId!].notes.count - 1 {
                if MyList.defaultLists[listId!].notes[noteToSaveId].title == titleLabel.text && MyList.defaultLists[listId!].notes[noteToSaveId].subtitle == subtitleLabel.text {
                    MyList.defaultLists[listId!].notes[noteToSaveId].done = true
                }
            }
        }
    }
}
