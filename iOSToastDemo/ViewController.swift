//
//  ViewController.swift
//  iOSToastDemo
//
//  Created by Frank Hu on 1/15/17.
//  Copyright © 2017 Sugarcube. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let msg = "Toast a message! Toast a paragraph or a short message."
    
    @IBAction func e1(_ sender: Any) {
        // Ex 1 - General Usage
        view.addSubview(Toast.alert(message: msg))
    }
    
    @IBAction func e2(_ sender: Any) {
        // Ex 2 - Configure Styles
        let style = ToastStyle()
        style.textColor = UIColor.black
        style.backColor = UIColor.white
        style.borderColor = UIColor.darkGray
        style.borderWidth = 3
        style.fontSize = 25
        style.padding = 25
        style.cornerRadius = 15
        style.centerAt = .bottom
        style.maxWidth = 300
        view.addSubview(Toast.alert(message: msg, style: style))
        
        // Ex 5 - Runs Handler After Toast Expires
        Toast.isActive() {
            print("Run completion block")
        }
    }
    
    @IBAction func e3(_ sender: Any) {
        let style = ToastStyle()
        style.centerAt = .positionAt(CGPoint(x: 200, y: 110))
        
        // Ex 3 - Configure Toast Active Duration and Animation Speed
        view.addSubview(Toast.alert(message: msg, duration: 2.0, speed: 0.5, style: style))
    }
    
    @IBAction func clearAll(_ sender: Any) {
        // Ex 4 - Removing All Toasts
        Toast.removeAllToasts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

