//
//  CellInfo.swift
//  tabBarFromScratch
//
//  Created by cems ios on 7/23/18.
//  Copyright © 2018 cems ios. All rights reserved.
//

import Foundation
import SwiftyJSON
class CellInfo {
    //Mark: Properties
    var lable: String?

    
    init(with json: JSON) {
        
        self.lable = json["secret"].string
        
       
    }
}
