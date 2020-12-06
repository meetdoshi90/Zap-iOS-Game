//
//  statisticsViewController.swift
//  iOSFinal
//
//  Created by msb on 25/11/20.
//

import UIKit
import Charts
class statisticsViewController: UIViewController, ChartViewDelegate {
    
    var barChart = BarChartView()
    
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBOutlet weak var avgResponseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utilities.styleFilledButton(playAgainButton)
        Utilities.styleHollowLabel(avgResponseLabel)
        
        
        barChart.delegate = self
        //view styling
        barChart.frame = CGRect(x: 0, y: 0, width: (self.view.frame.size.width), height: (self.view.frame.size.width))
        barChart.center = view.center
        view.addSubview(barChart)
        print(Constants.responseArray.totalresponsetime)
        var entries = [BarChartDataEntry]()
        for i in 1...5{
            //Appending data to a BarChartDataEntry type array
            entries.append(BarChartDataEntry(x: Double(i), y: Double(Int(Constants.responseArray.totalresponsetime[i-1] * 1000))))
        }
        
        let set = BarChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.colorful()
        
        let data = BarChartData(dataSet: set)
        barChart.data = data
        
        var total = 0.00
        for i in Constants.responseArray.totalresponsetime{
            total = total + i
        }
        let avg = Int((total/5)*1000)
        avgResponseLabel.text = "Avg. Response Time = \(avg) ms"
        print(data)
}
    
    @IBAction func playAgainTapped(_ sender: UIButton) {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarViewController) as? tabBarViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
}

