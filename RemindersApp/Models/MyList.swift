//
//  MyList.swift
//  RemindersApp
//
//  Created by Angelina on 05.08.2020.
//  Copyright © 2020 Angelina. All rights reserved.
//

import Foundation

struct MyList {
    let id: Int
    let title: String
    var amountOfReminders: Int
    var notesInList = [Note]()
}

extension MyList {
    
    static var myLists: [MyList] = {
        var myLists = [MyList]()
        myLists.append(MyList(id: 0, title: "New", amountOfReminders: 0))
        myLists.append(MyList(id: 1, title: "Swift HW", amountOfReminders: 0))
        myLists.append(MyList(id: 2, title: "Education", amountOfReminders: 0))
        myLists.append(MyList(id: 3, title: "Podcasts", amountOfReminders: 0))
        myLists.append(MyList(id: 4, title: "Books", amountOfReminders: 0))
        return myLists
    }()
    
    mutating func addNote(with id: Int, title: String, description: String) {
        notesInList.append(Note(id: id, title: title, description: description))
    }
}
