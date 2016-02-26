//
//  PersistenceService.swift
//  Tip Calculator
//
//  Created by Tien on 2/27/16.
//  Copyright © 2016 Tien. All rights reserved.
//
import Foundation

let tipSavedKey = "tipPercent"
let defaultTipPercent = 10

extension NSUserDefaults {

    func saveTipPercent(tipPercent:Int) {
        NSUserDefaults.standardUserDefaults().setInteger(tipPercent, forKey: tipSavedKey)
    }
    
    func savedTipPercent() -> Int {
        if let _ = NSUserDefaults.standardUserDefaults().objectForKey(tipSavedKey) {
            return NSUserDefaults.standardUserDefaults().integerForKey(tipSavedKey);
        }
        return defaultTipPercent
    }
}
