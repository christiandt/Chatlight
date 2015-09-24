//
//  Settings.swift
//  ParseStarterProject-Swift
//
//  Created by Christian Dancke Tuen on 14/09/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import CoreData

@objc(Settings)
class Settings: NSManagedObject {

    @NSManaged var username: String
    @NSManaged var password: String

}
