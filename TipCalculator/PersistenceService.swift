//
//  PersistenceService.swift
//  Tip Calculator
//
//  Created by Tien on 2/27/16.
//  Copyright © 2016 Tien. All rights reserved.
//
import Foundation

private let tipSavedKey = "tipPercent"
private let billAmountSavedKey = "billAmount"
private let lastOpened = "lastOpened"
private let defaultTipPercent = 10

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
    
    func saveBillAmount(billAmount:Double) {
        NSUserDefaults.standardUserDefaults().setDouble(billAmount, forKey: billAmountSavedKey)
    }
    
    func savedBillAmount() -> Double {
        if let _ = NSUserDefaults.standardUserDefaults().objectForKey(billAmountSavedKey) {
            return NSUserDefaults.standardUserDefaults().doubleForKey(billAmountSavedKey);
        }
        return 0
    }
    
    func saveLastOpened(lastOpen:Double) {
        NSUserDefaults.standardUserDefaults().setDouble(lastOpen, forKey: lastOpened)
    }
    
    func savedLastOpened() -> Double {
        if let _ = NSUserDefaults.standardUserDefaults().objectForKey(lastOpened) {
            return NSUserDefaults.standardUserDefaults().doubleForKey(lastOpened);
        }
        return 0
    }
}
