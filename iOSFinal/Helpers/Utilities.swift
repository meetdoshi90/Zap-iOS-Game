//
//  Utilities.swift
//  iOSFinal
//
//  Created by msb on 23/11/20.
//
//  This file is not written by me. I'm merely using it for styling textfields
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 93/255, green: 0/255, blue: 149/255, alpha: 1).cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = UIColor.init(red: 93/255, green: 0/255, blue: 149/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    static func styleHollowLabel(_ label:UILabel){
        //Hollow rounded corner style
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.cornerRadius = 25.0
        label.tintColor = UIColor.black
        
    }
    
    
// This function is written by me but the pattern matching scheme was courtesy of the internet
    /* link-
     https://iosdevcenters.blogspot.com/2017/06/password-validation-in-swift-30.html
     */
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    //sets the rules label text field to the following content
    static func setrulesLabel(_ label:UILabel){
        let rulestext = "Rules to be followed are quite simple! \nRemember\n \nPay attention to the numbers coming up on the screen all the time. The numbers will be displayed once and then are made invisible, now the timer starts.\n Tick - Tock \n Now you have to remember the numbers and enter them correctly. The numbers will be randomized so stay Sharp! \nGet the highest score and challenge your friends to do the same.\nZap\n Test your response time. You will be tested 5 times and analytics will give you your response time. \nGood Luck."
        label.text = rulestext
        label.sizeToFit()
        
    }
    
}
