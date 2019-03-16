//
//  Category.swift
//  Task List
//
//  Created by Vinayak Purohit on 12/03/19.
//  Copyright © 2019 Vinayak Purohit. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
