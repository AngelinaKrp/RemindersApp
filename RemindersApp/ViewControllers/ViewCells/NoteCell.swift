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
            selection(sender: checkButton, isSelected: true, titleAlpha: 0.4, subtitleAlpha: 0.4)
        } else {
            selection(sender: checkButton, isSelected: false, titleAlpha: 1, subtitleAlpha: 1)
        }
    }
    // MARK: - Private methods
    
    private func selection(sender: UIButton, isSelected: Bool, titleAlpha: CGFloat, subtitleAlpha: CGFloat) {
        sender.isSelected = isSelected
        titleLabel.alpha = titleAlpha
        subtitleLabel.alpha = subtitleAlpha
    }
    
    // Configure the view for the selected state
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkButton.addTarget(self, action: #selector(checkButtonClickes), for: .touchUpInside)
    }
    
    @objc func checkButtonClickes(sender: UIButton) {
        for (noteToSaveId, _) in MyList.defaultLists[listId!].notes.enumerated() {
            if MyList.defaultLists[listId!].notes[noteToSaveId].title == titleLabel.text && MyList.defaultLists[listId!].notes[noteToSaveId].subtitle == subtitleLabel.text {
                if sender.isSelected {
                    selection(sender: sender, isSelected: false, titleAlpha: 1, subtitleAlpha: 1)
                    MyList.defaultLists[listId!].notes[noteToSaveId].done = false
                } else {
                    selection(sender: sender, isSelected: true, titleAlpha: 0.4, subtitleAlpha: 0.4)
                    MyList.defaultLists[listId!].notes[noteToSaveId].done = true
                }
            }
        }
    }
}
