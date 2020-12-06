//
//  computerViewController.swift
//  iOSFinal
//
//  Created by msb on 23/11/20.
//

import UIKit

class computerViewController: UIViewController {

    
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBOutlet weak var tapToBeginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        Utilities.styleHollowButton(backButton)
    }
    //On button tap transition to tab bar controller screen
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarViewController) as? tabBarViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    
    @IBAction func beginButtonTapped(_ sender: UIButton) {
        self.transitionToHome()
    }
    
}
