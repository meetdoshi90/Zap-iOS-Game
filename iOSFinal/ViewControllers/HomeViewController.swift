//
//  HomeViewController.swift
//  iOSFinal
//
//  Created by msb on 23/11/20.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class HomeViewController: UIViewController {

    
    
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var profileLabel: UILabel!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var playwithfriendButton: UIButton!
    
    @IBOutlet weak var playwithcomputerButton: UIButton!
    
    @IBOutlet weak var rulesButton: UIButton!
    
    func setUpElements(){
        Utilities.styleFilledButton(playwithfriendButton)
        Utilities.styleFilledButton(playwithcomputerButton)
        Utilities.styleFilledButton(rulesButton)
    }
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.computerViewController) as? computerViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        setUpElements()
        //Retrieve current user email which is the document id for the database
        guard let email = Auth.auth().currentUser?.email else{return}
        let db = Firestore.firestore()
        let objref = db.collection("users").document(email)
        objref.getDocument{ (document, error) in
            if let document = document, document.exists {
                //dataDescription stores the fetched document
                let dataDescription = document.data()
                // Showing the fetched user id onto the label field
                let dict = dataDescription!  as [String:  Any]
                self.nameLabel.text =  (dict["firstname"] as! String)
                
            } else {
                //Failed to fetch document
                self.nameLabel.text = "Error loading Profile"
                print("Failed to fetch document")
            }
            
        }
    
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        
        self.transitionToHome()
    }
    
    
    
    @IBAction func leaderboardButtonTapped(_ sender: Any) {
        
    }
    
    
    @IBAction func rulesButtonTapped(_ sender: Any) {
        
    }
    
}
