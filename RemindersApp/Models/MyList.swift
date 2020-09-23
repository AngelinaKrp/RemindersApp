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
    var remindersCount: Int
    var notes = [Note]()
}

extension MyList {
    
    static var defaultLists: [MyList] = {
        var myLists = [MyList]()
        myLists.append(MyList(id: 0, title: "New", remindersCount: 0))
        myLists.append(MyList(id: 1, title: "Swift HW", remindersCount: 0))
        myLists.append(MyList(id: 2, title: "Education", remindersCount: 0))
        myLists.append(MyList(id: 3, title: "Podcasts", remindersCount: 0))
        myLists.append(MyList(id: 4, title: "Books", remindersCount: 0))
        return myLists
    }()
    
    mutating func addNote(with id: Int, title: String, description: String) {
        notes.append(Note(id: id, title: title, description: description))
    }
}
