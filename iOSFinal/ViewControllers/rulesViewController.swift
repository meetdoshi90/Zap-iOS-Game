//
//  rulesViewController.swift
//  iOSFinal
//
//  Created by msb on 23/11/20.
//

import UIKit

class rulesViewController: UIViewController {

    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var rulesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Styling
        Utilities.styleFilledButton(backButton)
        Utilities.styleFilledButton(logoutButton)
        Utilities.setrulesLabel(rulesLabel)
        Utilities.styleHollowLabel(rulesLabel)
    }
    


}
