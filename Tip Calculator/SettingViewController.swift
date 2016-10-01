//
//  SettingViewController.swift
//  Tip Calculator
//
//  Created by Quy Tran on 9/28/16.
//  Copyright © 2016 Quy Tran. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    let userDefault = UserDefaults.standard
    @IBOutlet weak var defaultPercentageSegment: UISegmentedControl!
    @IBOutlet weak var defaultThemeSegment: UISegmentedControl!
    @IBOutlet weak var tipPercentageTxt: UILabel!
    @IBOutlet weak var themeTxt: UILabel!
    
    func assignTheme() {
        Style.loadTheme()
        self.view.backgroundColor = Style.backgroundColor
        self.tipPercentageTxt.textColor = Style.textColor
        self.themeTxt.textColor = Style.textColor
        self.defaultPercentageSegment.tintColor = Style.textColor
        self.defaultThemeSegment.tintColor = Style.textColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefault = UserDefaults.standard
        if let segmentVal = userDefault.object(forKey: "defaultPercentageVal") as? Int {
            self.defaultPercentageSegment.selectedSegmentIndex = segmentVal
        }
        
        if let themeSegmentVal = userDefault.object(forKey: "theme") as? Int {
            self.defaultThemeSegment.selectedSegmentIndex = themeSegmentVal
            
        }
        assignTheme()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func setDefaultTipPercentage(_ sender: AnyObject) {
        userDefault.set(self.defaultPercentageSegment.selectedSegmentIndex, forKey: "defaultPercentageVal")
        userDefault.synchronize()
    }
    
    @IBAction func setDefaultTheme(_ sender: AnyObject) {
        userDefault.set(self.defaultThemeSegment.selectedSegmentIndex, forKey: "theme")
        userDefault.synchronize()
        assignTheme()
    }
    
}
