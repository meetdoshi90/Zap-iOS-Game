//
//  rememberViewController.swift
//  iOSFinal
//
//  Created by msb on 25/11/20.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


class rememberViewController: UIViewController {

    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var userInputTextField: UITextField!
    
    @IBOutlet weak var verifyButton: UIButton!
    
    
    var numberoftaps = 0
    var numberofdigits = 1.00
    var score = 0
    var gameover = false
    var question = 0
    var timercount = 0.00
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpElements()
        progressBar.progress = 0
        verifyButton.setTitle("Begin", for: .normal)
        questionLabel.text = "Ready to play? \nHit the Begin Button"
    }
    
    
    
    
    
    func setUpElements(){
        Utilities.styleHollowButton(backButton)
        Utilities.styleHollowLabel(questionLabel)
        progressBar.progressTintColor = UIColor.black
        Utilities.styleTextField(userInputTextField)
        Utilities.styleHollowButton(verifyButton)
        
        
    }
    
    
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
    transitionToHome()
    }
    
    
    @IBAction func verifyButtonTapped(_ sender: UIButton) {
        if gameover == false{
        numberoftaps += 1
            if numberoftaps == 1
            {
            verifyButton.setTitle("Verify", for: .normal)
            }
            else
            {
            checkAns()
            }
        displayQues()
        }
        else
        {
            //Gameover
            transitionToHome()
        }
    }
    
    func checkAns()
    {
        
        let enteredanswer = Int(userInputTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        print(enteredanswer!)
        print(question)
            if (enteredanswer!) == question
            {
                score += 1
                numberofdigits += 1
                userInputTextField.text = ""
                //Retrieve current user email which is the document id for the database to get a reference to data
                guard let email = Auth.auth().currentUser?.email else{return}
                let db = Firestore.firestore()
                //update score
                db.collection("users").document(email).updateData(["score": score])
                
            }
            else
            {
                gameover = true
                questionLabel.alpha = 1
                questionLabel.text = "Game Over \nYour Score \(score)"
                verifyButton.setTitle("Play Again?", for: .normal)
            }
        
    }
    
    func displayQues(){
        if gameover == false{
        questionLabel.alpha = 1
        question = randomNumberGenerator(numberofdigits)
        questionLabel.text = String(question)
        timercount = 0.0
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(counter), userInfo: nil, repeats: true)
        }
        
    }
    
    
    @objc func counter()
    {
        timercount += 0.01
        
        let temp = String(format: "%.2f", timercount)
        let temp1 = String(format: "%.2f", numberofdigits)
        if temp1 == temp{
            timer.invalidate()
            progressBar.progress = 0
            questionLabel.alpha = 0
            print("Timer went off")
        }
        else{
            questionLabel.text = "\(question)  \n" + String(format: "Time Lapsed %.2f", timercount)
            progressBar.progress = Float(timercount/numberofdigits)
        }
        
        
    }
    @objc func hideQuestion()
    {
        questionLabel.alpha = 0
    }
    
    func randomNumberGenerator (_ n: Double) -> Int{
        let limit = pow(10 , n)
        return (Int.random(in: 0..<Int(limit)))
    }
    
    
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarViewController) as? tabBarViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
            
    }
    
}
