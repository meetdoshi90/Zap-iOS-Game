//
//  SignUpViewController.swift
//  iOSFinal
//
//  Created by msb on 23/11/20.
//

import UIKit

import FirebaseAuth
import FirebaseFirestore
class SignUpViewController: UIViewController {
   
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    @IBOutlet weak var goBackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    func setUpElements(){
        //Setting Error Label Visibility to 0 unless error occurs
        errorLabel.alpha=0
        //Styling
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(goBackButton)
    }

    //This function checks and valdidates data
    /*
     If everything is right this function returns nil
     else if wrong then returns error message
     */
    func validateFields() -> String?{
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
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
    
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        //Check if the credentials are valid and inform user
        let error = validateFields()
        if error != nil{
            showError(error!)
        }
        else{
            
            //Cleaned versions of data
            let firstName = firstNameTextField.text!
            let lastName = lastNameTextField.text!
            let email = emailTextField.text! 
            let password = passwordTextField.text!
            //Create the user and transition to the home screen
            
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
            
            if err != nil{
                    //Show Error creating User
                    self.showError("Error Creating User")
                }
                else{
                    //User was successfully created now store the username and password
                    let db = Firestore.firestore()
                    
                    db.collection("users").document(email).setData(["firstname" : firstName, "lastname" : lastName,"score" : 0, "uid" : email]) {(error) in
                        if error != nil{
                            //User was successfully created but the data could not be fetched
                            self.showError("User data could not be fetched")
                        }
                    }
                    
                    //Transition to GAME
                    self.transitionToHome()
                }
            }
        }
        	
        
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
}
