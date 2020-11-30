//
//  GlobalVariables.swift
//  NewsApp
//
//  Created by Amna on 11/19/20.
//  Copyright © 2020 Amna. All rights reserved.
//

import Foundation
class  GlobalVariables {
    static let shared = GlobalVariables()
       private init() {}
    var egyptArticales = [AnyObject]()
    var appleArticales = [AnyObject]()
    var sportArticales = [AnyObject]()
    var bitcoinsArticales = [AnyObject]()
}
