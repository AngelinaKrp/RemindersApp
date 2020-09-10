//
//  SearchTableViewCell.swift
//  RemindersApp
//
//  Created by Angelina on 13.08.2020.
//  Copyright © 2020 Angelina. All rights reserved.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    // MARK: - Properties

    var idOfNote: Int?
    var idOfList: Int?
    let textAlpha: CGFloat = 1.0
    let textAlphaChecked: CGFloat = 0.4
    
    // MARK: - Static properties
    
    static let reusableId = "SearchTableViewCell"
    
    // MARK: - Public methods
    
    func configuree(with list: MyList, model: Note) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        idOfList = list.id
        idOfNote = model.id
        
        if model.done == true {
            checkButton.isSelected = true
            titleLabel.alpha = textAlphaChecked
            subtitleLabel.alpha = textAlphaChecked
            checkButton.setImage(UIImage(systemName: "checkmark.circle"), for:.normal)
        } else {
            checkButton.isSelected = false
            titleLabel.alpha = textAlpha
            subtitleLabel.alpha = textAlpha
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
            titleLabel.alpha = textAlpha
            subtitleLabel.alpha = textAlpha

            for noteToSaveId in 0...MyList.myLists[idOfList!].notesInList.count - 1 {
                if MyList.myLists[idOfList!].notesInList[noteToSaveId].title == titleLabel.text && MyList.myLists[idOfList!].notesInList[noteToSaveId].subtitle == subtitleLabel.text {
                    MyList.myLists[idOfList!].notesInList[noteToSaveId].done = false
                }
            }
        } else {
            sender.isSelected = true
            titleLabel.alpha = textAlphaChecked
            subtitleLabel.alpha = textAlphaChecked
            checkButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            
            for noteToSaveId in 0...MyList.myLists[idOfList!].notesInList.count - 1 {
                if MyList.myLists[idOfList!].notesInList[noteToSaveId].title == titleLabel.text && MyList.myLists[idOfList!].notesInList[noteToSaveId].subtitle == subtitleLabel.text {
                    MyList.myLists[idOfList!].notesInList[noteToSaveId].done = true
                }
            }
        }
    }
}
