//
//  settingsViewController.swift
//  iOSFinal
//
//  Created by msb on 23/11/20.
//

import UIKit
import Firebase
import FirebaseFirestore



class settingsViewController: UIViewController {

    
    var objsignUpViewController = SignUpViewController.self
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var changeFirstNameButton: UIButton!
    
    @IBOutlet weak var changeLastNameButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    //SetUp Styling
    func setUpElements(){
        errorLabel.alpha = 0
        Utilities.styleFilledButton(backButton)
        Utilities.styleFilledButton(logoutButton)
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleFilledButton(changeFirstNameButton)
        Utilities.styleFilledButton(changeLastNameButton)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    
    }
    
    
    //This function checks and valdidates data
    /*
     If everything is right this function returns nil
     else if wrong then returns error message
     */
    func validateFields() -> String?{
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" &&
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            && emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            {
                return "Please enter email field and one of the name fields"
            }
        else{
        return nil
        }
    }

    
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    //Change error message to null after 2 secs
    @objc func changeErrorLabelalpha(){
        errorLabel.text = ""
    }
    
    @IBAction func changeFirstButtonTapped(_ sender: UIButton) {
        //Check if the credentials are valid and inform user
        let error = validateFields()
        if error != nil{
            showError(error!)
        }
        else{
            //Cleaned versions of data
            let email = emailTextField.text!
            let firstName = firstNameTextField.text!
            let db = Firestore.firestore()
            let objref = db.collection("users").document(email)
            objref.setData(["firstname":firstName], merge: true)
            showError("Successful")
            Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeErrorLabelalpha), userInfo: nil, repeats: false)
        }
        
        
        }
    
    @IBAction func chagneLastButtonTapped(_ sender: Any) {
        //Check if the credentials are valid and inform user
        let error = validateFields()
        if error != nil{
            showError(error!)
        }
        else{
            //Cleaned versions of data
            let email = emailTextField.text!
            let lastName = lastNameTextField.text!
            let db = Firestore.firestore()
            let objref = db.collection("users").document(email)
            objref.setData(["lastname":lastName], merge: true)
            showError("Successful")
            Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeErrorLabelalpha), userInfo: nil, repeats: false)        }
        
        
        
    }
    
    


}
