//
//  SettingsViewController.swift
//  Tip Calculator
//
//  Created by Tien on 2/27/16.
//  Copyright © 2016 Tien. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tblTipPercent: UITableView!
    let tipUtils = TipUtils()
    
    override func viewDidLoad() {
        self.title = "Settings"
        self.tblTipPercent.dataSource = self
        self.tblTipPercent.delegate = self
    }
}

extension SettingsViewController:UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        return 0
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Default Tip amount"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("cell_tip")

        let tipPercent = NSUserDefaults.standardUserDefaults().savedTipPercent()
        let tipIndex = self.tipUtils.selectedIndexWithTipPercent(tipPercent)
        
        
        cell?.textLabel?.text = "\(self.tipUtils.tipPercent(indexPath.row))%"
        if indexPath.row == tipIndex {
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell?.accessoryType = UITableViewCellAccessoryType.None
        }
        
        return cell!;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tipPercent = self.tipUtils.tipPercent(indexPath.row)
        NSUserDefaults.standardUserDefaults().saveTipPercent(tipPercent)
        
        tableView.reloadData()
    }

}
