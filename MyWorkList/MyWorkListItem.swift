//
//  MyWorkListItem.swift
//  MyWorkList
//
//  Created by kalimi venkata vijay vardhan on 10/12/17.
//  Copyright © 2017 kalimi venkata vijay vardhan. All rights reserved.
//

import Foundation
class MyWorkListItem : NSObject{
    var text = ""
    var checkedState = false
    func toggleChecked(){
        checkedState = !checkedState
    }
}
