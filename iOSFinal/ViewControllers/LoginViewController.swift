//
//  LoginViewController.swift
//  iOSFinal
//
//  Created by msb on 23/11/20.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var gobackButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        errorLabel.alpha=0
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
        Utilities.styleHollowButton(gobackButton)
    }
    func validateFields() -> String? {
         if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            {
                return "Please enter every field"
            }
        //Validate the fields using function from Utilities.swift
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            //Please enter a valid password
            return "Please make sure than your password is atleast 8 characters long, a special character and a number."
        }
        return nil
        
    }
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
        
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        //Validate login credentials
        let error = validateFields()
        if error != nil{
            showError(error!)
        }
        else{
        //After checking all fields are valid
        //Text fields read
        let email = emailTextField.text!
        let password = passwordTextField.text!
        //Sign in user credentials to Firestore
            Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
                
                if err != nil {
                    //Sign In Failed
                    self.errorLabel.text = err!.localizedDescription
                    self.errorLabel.alpha = 1
                }
                else{
                    //Transition to GAME
                    self.transitionToHome()
                }
                
                
            }
        }
    }
    

}
