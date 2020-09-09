//
//  SearchTableViewCell.swift
//  RemindersApp
//
//  Created by Angelina on 13.08.2020.
//  Copyright © 2020 Angelina. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    // MARK: - Private properties
    // Change private?
    static let reusableId = "SearchTableViewCell"
    var idOfNote: Int?
    var idOfList: Int?
    
    // MARK: - Private methods
    
    func configuree(with list: MyList, model: Note) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        idOfList = list.id
        idOfNote = model.id
        
        if model.done == true {
            checkButton.isSelected = true
            titleLabel.alpha = 0.4
            subtitleLabel.alpha = 0.4
            checkButton.setImage(UIImage(systemName: "checkmark.circle"), for:.normal)
        } else {
            checkButton.isSelected = false
            titleLabel.alpha = 1
            subtitleLabel.alpha = 1
            checkButton.setImage(UIImage(systemName: "circle"), for:.normal)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkButton.addTarget(self, action: #selector(checkButtonClickes), for: .touchUpInside)
    }
    
    @objc func checkButtonClickes (sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            checkButton.setImage(UIImage(systemName: "circle"), for:.normal)
            titleLabel.alpha = 1
            subtitleLabel.alpha = 1

            for noteToSaveId in 0...MyList.myLists[idOfList!].notesInList.count - 1 {
                if MyList.myLists[idOfList!].notesInList[noteToSaveId].title == titleLabel.text && MyList.myLists[idOfList!].notesInList[noteToSaveId].subtitle == subtitleLabel.text {
                    MyList.myLists[idOfList!].notesInList[noteToSaveId].done = false
                }
            }
        } else {
            sender.isSelected = true
            titleLabel.alpha = 0.4
            subtitleLabel.alpha = 0.4
            checkButton.setImage(UIImage(systemName: "checkmark.circle"), for:.normal)
            
            for noteToSaveId in 0...MyList.myLists[idOfList!].notesInList.count - 1 {
                if MyList.myLists[idOfList!].notesInList[noteToSaveId].title == titleLabel.text && MyList.myLists[idOfList!].notesInList[noteToSaveId].subtitle == subtitleLabel.text {
                    MyList.myLists[idOfList!].notesInList[noteToSaveId].done = true
                }
            }
        }
    }
}

