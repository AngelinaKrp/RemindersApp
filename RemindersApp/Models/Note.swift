//
//  Note.swift
//  RemindersApp
//
//  Created by Angelina on 05.08.2020.
//  Copyright © 2020 Angelina. All rights reserved.
//

import Foundation

struct Note {
    let id: Int
    let title: String
    let description: String
    var done: Bool = false
    
    var subtitle: String {
        String(description.prefix(80))
    }
}
