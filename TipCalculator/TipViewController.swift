//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Tien on 2/20/16.
//  Copyright © 2016 Tien. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
    
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var lbTipAmount: UILabel!
    @IBOutlet weak var lbTotalAmount: UILabel!
    @IBOutlet weak var btn10PercentTip: UIButton!
    @IBOutlet weak var btn15PercentTip: UIButton!
    @IBOutlet weak var btn20PercentTip: UIButton!
    
    var tipPercentIndex = 0
    let tipUtil = TipUtils()
    let formatter = NSNumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
        
        self.tfAmount.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        self.loadSavedData()
        
        self.updateTip()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tfAmount.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.tfAmount.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func doCheck() {
        let lastOpen = NSUserDefaults.standardUserDefaults().savedLastOpened()
        let current = NSDate().timeIntervalSince1970
        if current - lastOpen > 5 {
            NSUserDefaults.standardUserDefaults().saveBillAmount(0)
        }
    }
    
    private func setupUI() {
        self.title = "Tip Calculator"
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("onTapOutside")));
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: UIBarButtonItemStyle.Plain, target: self, action: "onSettingMenuClicked");
    }

    @IBAction private func onTextChanged(sender:UIView!) {
        self.updateTip()
    }
    
    @objc private func onSettingMenuClicked() {
        let settingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("setting_vc")
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    
    @IBAction private func onButtonClicked(button:UIButton) {
        self.tipPercentIndex = 0;
        
        let buttons = [self.btn10PercentTip, self.btn15PercentTip, self.btn20PercentTip];
        
        for (var i = 0; i < buttons.count; i++) {
            if button == buttons[i] {
                self.tipPercentIndex = i;
            } 
        }
        
        self.updateTipButtons(self.tipPercentIndex)
        self.updateTip()
    }
    
    private func updateTip() {
        let bill = Double(self.tfAmount.text!) ?? 0
        let tipPercent = self.tipUtil.tipPercent(self.tipPercentIndex)
        let tipAmount = self.tipUtil.tipAmount(billAmount:bill, tipPercent:tipPercent)
        let totalAmount = self.tipUtil.totalAmount(billAmount: bill, tipAmount: tipAmount)
        
        
        
        lbTipAmount.text = "\(formatter.stringFromNumber(tipAmount)!)"
        lbTotalAmount.text = "\(formatter.stringFromNumber(totalAmount)!)"
    }
    
    @objc private func onTapOutside() {
        self.tfAmount.resignFirstResponder();
    }
    
    
    
    private func loadSavedData() {
        self.tipPercentIndex = self.tipUtil.selectedIndexWithTipPercent(NSUserDefaults.standardUserDefaults().savedTipPercent())
        self.updateTipButtons(self.tipPercentIndex)

    }
    
    private func updateBillAmountTextField() {
        let billAmount = NSUserDefaults.standardUserDefaults().savedBillAmount()
        if billAmount != 0 {
            self.tfAmount.text = "\(formatter.stringFromNumber(billAmount)!)"
        } else {
            self.tfAmount.text = ""
        }
    }
    
    private func updateTipButtons(selectedIndex:Int) {
        let buttons = [self.btn10PercentTip, self.btn15PercentTip, self.btn20PercentTip];
        
        let selectedImage = UIImage(named: "heart_fill")
        let normalImage = UIImage(named: "heart_empty")
        var currentImage = selectedImage
        
        for (var i = 0; i < buttons.count; i++) {
            buttons[i].setImage(currentImage, forState: UIControlState.Normal)
            buttons[i].setImage(currentImage, forState: UIControlState.Highlighted)
            if i == selectedIndex {
                currentImage = normalImage
            }
        }
    }
}

extension TipViewController:UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return false }
        
        let updatedText = (text as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        // Empty this textfield
        if updatedText.characters.count == 0 {
            return true
        }
        
        if !isValidDouble(updatedText) {
            return false;
        }
        
        return isValidLength(updatedText)
    }
    
    func isValidDouble(text:String) -> Bool {
        if let _ = text.doubleValue {
            return true
        } else {
            return false
        }
    }
    
    func isValidLength(text:String) -> Bool {
        return text.characters.count >= 0 && text.characters.count <= 8
    }
}

extension String {
    // I know this check is really stupid.
    var doubleValue:Double? {
        return NSNumberFormatter().numberFromString(self)?.doubleValue
    }
}

