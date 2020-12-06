//
//  zapViewController.swift
//  iOSFinal
//
//  Created by msb on 25/11/20.
//
//Thanks to Burhaan Poonawala for letting me borrow his mac
import UIKit

class zapViewController: UIViewController {

    //count = 10 gives 10 taps therefore 5 round
    var count = 10
    var scoreArray = [Double]()
    var timer = Timer()
    var responsetimer = Timer()
    var startorstop = false
    var gamehasbegun = false
    //random variable to generate wait time to change screen to green
    var random = 0.0
    var totalresponsetime = 0.000
    var finalresponsetime = [Double]()
    var roundnumber = 1
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var tapButton: UIButton!
    
    @IBOutlet weak var viewStatsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        
        Utilities.styleHollowButton(backButton)
        messageLabel.text = " Tap on the red color to begin"
        tapButton.setTitle("", for: .normal)
        tapButton.backgroundColor = UIColor.red
        tapButton.titleLabel?.lineBreakMode = .byWordWrapping
        viewStatsButton.alpha = 0
        viewStatsButton.setTitle("", for: .normal)
        tapButton.layer.cornerRadius = 25.0
            }
    
    
    @IBAction func tapButtonTapped(_ sender: Any) {
        
        if gamehasbegun == false
        {
        if count > 0
        {
            startorstop = !startorstop
        //Begin Timer
        //Boolean variable to check if button tapped is for starting or stopping the game
            if startorstop
            {
                gameStart()
            }
            else
            {
                gameStop()
            }
        count = count - 1
        }
        else
        {
            //Game over show analytics
            //Transition to play again
            
            
        }
            
        }
    }
    
    func gameStart()
    {
        viewStatsButton.setTitle("Round number \(roundnumber)", for: .normal)
        roundnumber += 1
        Utilities.styleHollowButton(viewStatsButton)
        viewStatsButton.alpha = 1
        
        
        totalresponsetime = 0.000
        tapButton.backgroundColor = UIColor.red
        messageLabel.text = "Game has started pay attention"
        //Generate random delay timer go off time
        random = Double.random(in: 1.0...5.0)
        //Timer start logic
        gamehasbegun = true
        tapButton.setTitle("Tap when color changes to green", for: .normal)
        tapButton.tintColor = UIColor.white
        timer = Timer.scheduledTimer(timeInterval: random, target: self, selector: #selector(triggerResponseTime), userInfo: nil, repeats: false)
        
        
    }
    func gameStop()
    {
        //End timer
        responsetimer.invalidate()
        //let temp = String(format: "%.3f", totalresponsetime)
        tapButton.backgroundColor = UIColor.red
        if count == 1{
            tapButton.setTitle("Game Finished \nView Stats", for: .normal)
            viewStatsButton.setTitle("View Stats", for: .normal)
            
        }
        else{
        tapButton.setTitle("Tap to begin next round", for: .normal)
        }
        tapButton.tintColor = UIColor.white
        //Setting fp precision
        let temp = Int(totalresponsetime*1000)
        messageLabel.text = "Voila \nYour Response Time is \(temp) ms"
        finalresponsetime.append(totalresponsetime)
        //passing value to another view controller
        Constants.responseArray.totalresponsetime.append(totalresponsetime)
        
        
    }
    //Func that starts the timer to check response time
    @objc func triggerResponseTime()
    {
        gamehasbegun = false
        tapButton.setTitle("Quick Tap!!", for: .normal)
        tapButton.backgroundColor = UIColor.green
        tapButton.tintColor = UIColor.black
        //Repeatedly call another function to store time lapsed
        responsetimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(responseTime), userInfo: nil, repeats: true)
    }
    //indirect function call
    @objc func responseTime()
    {
        totalresponsetime += 0.001
        let temp = Int(totalresponsetime*1000)
        messageLabel.text = "Time Lapsed \(temp) ms"
        
    }
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.statisticsViewController) as? statisticsViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
        
    }
    
    
    @IBAction func statsButtonTapped(_ sender: UIButton) {
        if roundnumber == 6{
        transitionToHome()
        }
        else{
            //
        }
    }
    
    }
