//
//  friendViewController.swift
//  iOSFinal
//
//  Created by msb on 23/11/20.
//

import UIKit
import FirebaseFirestore

struct stats{
    var firstname = ""
    var lastname = ""
    var score = 0
}



class friendViewController: UIViewController{

    @IBOutlet weak var topScorers: UITableView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var statsLabel: UILabel!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    
    
    var tableViewList = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
        topScorers.delegate = self
        topScorers.dataSource = self
        print("Debug")
        let db = Firestore.firestore()
        //This part gets a reference to the users collection
        db.collection("users").order(by: "score", descending: true).getDocuments(){ (querySnapshot, error) in
            if let err = error {
                    debugPrint("Error getting documents: \(err)")
                } else {
                    //guarding snapshot in case of error
                    guard let snapshot = querySnapshot?.documents else {return}
                    for document in snapshot {
                        let dataDescription = document.data()
                        // Showing the fetched user id onto the label field
                        var statdata = stats()
                        //Saving stats in a struct and passing defaults if there isn't one
                        statdata.firstname = dataDescription["firstname"] as? String ?? "Anonymous"
                        statdata.lastname = dataDescription["lastname"] as? String ?? ""
                        statdata.score = dataDescription["score"] as? Int ?? 0
                        //Appending stats
                        self.tableViewList.append(statdata.firstname + " " + statdata.lastname + " = " + String(statdata.score))
                        print(self.tableViewList)
                    }
                    //Reload tableView Data
                    self.topScorers.reloadData()
                    
                }
            
            
        }
        
        
        
    }
    func setUpElements(){
        Utilities.styleFilledButton(backButton)
        Utilities.styleFilledButton(logoutButton)
        statsLabel.text = "Stats"
    }


}


extension friendViewController: UITableViewDelegate{
    func tableViewDidEndMultipleSelectionInteraction(_ tableView: UITableView) {
        //
        print("TableView Row Selected")
    }
}

extension friendViewController: UITableViewDataSource{
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderBoard", for: indexPath)
        cell.textLabel?.text = tableViewList[indexPath.row]
        return cell
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewList.count
    }
    
    
}
