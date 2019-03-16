//
//  Item.swift
//  Task List
//
//  Created by Vinayak Purohit on 12/03/19.
//  Copyright © 2019 Vinayak Purohit. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var dateCreated : Date?
    @objc dynamic var done : Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
