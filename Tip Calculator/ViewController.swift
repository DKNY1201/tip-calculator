//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Quy Tran on 9/28/16.
//  Copyright © 2016 Quy Tran. All rights reserved.
//

import UIKit

struct Style {
    static var textColor = UIColor.white
    static var backgroundColor = UIColor.gray
    static var highlightColor = UIColor.green

    static func darkTheme() {
        textColor = UIColor.white
        backgroundColor = UIColor.init(red: 0.1216, green: 0.1216, blue: 0.1217, alpha: 1)
        highlightColor = UIColor.red
    }
    
    static func lightTheme() {
        textColor = UIColor.white
        backgroundColor = UIColor.init(red: 0.8667, green: 0.4588, blue: 0.3294, alpha: 1)
        highlightColor = UIColor.init(red: 0.2314, green: 0.8706, blue: 0.7843, alpha: 1)
    }
    
    static func loadTheme() {
        let userDefault = UserDefaults.standard
        if let storedTheme = userDefault.object(forKey: "theme") as? Int {
            switch storedTheme {
            case 0:
                darkTheme()
            case 1:
                lightTheme()
            default:
                darkTheme()
            }
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var billTxt: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipSegment: UISegmentedControl!
    @IBOutlet weak var tipTxt: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalTxt: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var separator: UIView!
    
    let userDefault = UserDefaults.standard
    
    func calculateTips () {
        let tipPercentage = [0.18, 0.2, 0.22]
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentage[tipSegment.selectedSegmentIndex]
        let total = bill + tip
        
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = NumberFormatter.Style.currency
        numberFormat.currencySymbol = "$"
        numberFormat.locale = Locale.current
        totalLabel.text = numberFormat.string(from: NSNumber(value: total))
        tipLabel.text = numberFormat.string(from: NSNumber(value: tip))
    }
    
    func selectSegment () {
        if let segmentVal = userDefault.object(forKey: "defaultPercentageVal") as? Int {
            self.tipSegment.selectedSegmentIndex = segmentVal
        }
    }
    
    func assignTheme() {
        Style.loadTheme()
        self.view.backgroundColor = Style.backgroundColor
        self.billTxt.textColor = Style.textColor
        self.tipTxt.textColor = Style.textColor
        self.tipLabel.textColor = Style.textColor
        self.totalTxt.textColor = Style.highlightColor
        self.totalLabel.textColor = Style.highlightColor
        self.separator.backgroundColor = Style.textColor
        self.tipSegment.tintColor = Style.textColor
    }
    
    func loadBill() {
        if let lastTime = userDefault.object(forKey: "lastTime") as? NSDate {
            let intervalTime = -lastTime.timeIntervalSinceNow
            if intervalTime <= 600 {
                if let lastBill = userDefault.object(forKey: "lastBill") as? String {
                    self.billField.text = lastBill
                }
            } else {
                userDefault.set(nil, forKey: "lastBill")
                userDefault.set(nil, forKey: "lastTime")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectSegment()
        assignTheme()
        loadBill()
        self.billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectSegment()
        calculateTips()
        Style.loadTheme()
        assignTheme()
    }


    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        calculateTips()
        let curDate = NSDate.init()
        userDefault.set(curDate, forKey: "lastTime")
        userDefault.set(self.billField.text, forKey: "lastBill")
        userDefault.synchronize()
    }
}

