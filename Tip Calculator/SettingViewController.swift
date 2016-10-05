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
    @IBOutlet weak var lightLabel: UILabel!
    @IBOutlet weak var darkLabel: UILabel!
    
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
        
        if let segmentVal = userDefault.object(forKey: "defaultPercentageVal") as? Int {
            self.defaultPercentageSegment.selectedSegmentIndex = segmentVal
        }
        if let themeSegmentVal = userDefault.object(forKey: "theme") as? Int {
            self.defaultThemeSegment.selectedSegmentIndex = themeSegmentVal
            
        }
        assignTheme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.defaultPercentageSegment.center.x += self.view.bounds.width
        self.defaultThemeSegment.center.x -= self.view.bounds.width
        
        self.lightLabel.alpha = 0;
        self.darkLabel.alpha = 0;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.defaultPercentageSegment.center.x -= self.view.bounds.width
            self.defaultThemeSegment.center.x += self.view.bounds.width
        }, completion: nil)
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
        if self.defaultThemeSegment.selectedSegmentIndex == 0 {
            UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
                self.darkLabel.alpha = 1
                self.darkLabel.transform = CGAffineTransform.init(scaleX: 4, y: 4)
                }, completion: { (true)
                    in
                    UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                        self.darkLabel.alpha = 0
                        }, completion: { (true)
                            in
                            self.darkLabel.transform = CGAffineTransform.identity
                    })
                    
            })
        } else {
            UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
                self.lightLabel.alpha = 1
                self.lightLabel.transform = CGAffineTransform.init(scaleX: 4, y: 4)
                }, completion: { (true)
                    in
                    UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                        self.lightLabel.alpha = 0
                        }, completion: { (true)
                            in
                            self.lightLabel.transform = CGAffineTransform.identity
                    })
                    
            })
        }
        
        
        userDefault.set(self.defaultThemeSegment.selectedSegmentIndex, forKey: "theme")
        userDefault.synchronize()
        assignTheme()
    }
}
