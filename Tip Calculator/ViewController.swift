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
    //static var
    static func darkTheme() {
        textColor = UIColor.white
        backgroundColor = UIColor.init(red: 0.098, green: 0.3176, blue: 0.4392, alpha: 1)
        highlightColor = UIColor.red
    }
    
    static func lightTheme() {
        textColor = UIColor.black
        backgroundColor = UIColor.init(red: 0.1647, green: 0.949, blue: 0.9922, alpha: 1)
        highlightColor = UIColor.red
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
    
    func calculateTips () {
        let tipPercentage = [0.18, 0.2, 0.22]
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentage[tipSegment.selectedSegmentIndex]
        let total = bill + tip
        
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = NumberFormatter.Style.decimal
        totalLabel.text = numberFormat.string(from: NSNumber(value: total))
        
        tipLabel.text = String(format: "$%.2f", tip)
        //totalLabel.text = String(format: "$%.2f", total)
        //totalLabel.text = numberFormat.string(from: NSNumber(Double: total))
        
    }
    
    func selectSegment () {
        let userDefault = UserDefaults.standard
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectSegment()
        assignTheme()
        self.billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    }
}

