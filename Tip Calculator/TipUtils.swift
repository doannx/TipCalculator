//
//  TipUtils.swift
//  Tip Calculator
//
//  Created by Tien on 2/27/16.
//  Copyright © 2016 Tien. All rights reserved.
//

import Foundation

class TipUtils: NSObject {
    /**
     Return tip amount for provided bill amount and tip percent.
     
     - parameter billAmount: bill amount
     - parameter tipPercent: tip percent (100 based)
     
     - returns: tip amount
     */
    func tipAmount(billAmount billAmount:Double, tipPercent:Int) -> Double {
        return billAmount * Double(tipPercent) / 100
    }
    
    /**
     Return total amount for provided bill amount and tip
     
     - parameter billAmount: bill amount
     - parameter tipAmount:  tip amount
     
     - returns: total pay
     */
    func totalAmount(billAmount billAmount:Double, tipAmount:Double) -> Double {
        return billAmount + tipAmount
    }
    
    /**
     Return pay per one person
     
     - parameter total:       total bill amount
     - parameter personCount: number of person
     
     - returns: how much a person should pay
     */
    func amountByPer(totalAmount total:Double, personCount:Int) -> Double {
        return total / Double(personCount)
    }
    
    func tipPercent(selectedIndex:Int) -> Int {
        switch selectedIndex {
        case 0:
            return 10
        case 1:
            return 15
        case 2:
            return 20
        default:
            return 0
        }
    }
    
    func selectedIndexWithTipPercent(tipPercent:Int) -> Int {
        switch tipPercent {
        case 10:
            return 0
        case 15:
            return 1
        case 20:
            return 2
        default:
            return 0
        }
    }
}
