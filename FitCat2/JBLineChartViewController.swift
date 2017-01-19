//
//  JBLineChartViewController.swift
//  FitCat2
//
//  Created by Ming Yang on 12/1/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//



import UIKit
import JBChartView
import Alamofire
import SwiftyJSON

class JBLineChartViewController: UIViewController, JBLineChartViewDelegate, JBLineChartViewDataSource {
    
    
    @IBOutlet weak var lineChart: JBLineChartView!
   
    
    var chartLegend = ["Initial", "Now"]
    var chartData = [0, 0]
    //    var lastYearChartData = [75, 88, 79, 95, 72, 55, 90]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.darkGray
        // line chart setup
        lineChart.backgroundColor = UIColor.darkGray
        lineChart.delegate = self
        lineChart.dataSource = self
        lineChart.minimumValue = 10
        lineChart.maximumValue = 30+10
        lineChart.reloadData()
        lineChart.setState(.collapsed, animated: false)
    
        Alamofire.request("http://mingplusyang.com/fitcatDB/getWeight.php?a1=\(1)").responseJSON { response in
            if let jsonData = response.result.value {
                let json = JSON(jsonData)
                self.chartLegend.removeAll()
                self.chartData.removeAll()
                self.chartLegend.append("Now")
            
                var i = 0
                while i < json["num"].intValue {
                    self.chartData.append(json["weight"][i]["data"].intValue)
                    self.chartLegend.append("Now")
                    i = i + 1
                }
                print("LINEE2")
                if(self.chartData.count == 0){
    
                } else{
                    self.lineChart.minimumValue = CGFloat(self.chartData.min()!)
                    self.lineChart.maximumValue = CGFloat(self.chartData.max()!+5)
                    self.lineChart.reloadData()
                    
                    print("LINEE3")
                }
            }
        }
        
        print("LINEE4")
        if(chartData.count == 0){
            
        } else{
            lineChart.minimumValue = CGFloat(chartData.min()!)
            lineChart.maximumValue = CGFloat(chartData.max()!+5)
            lineChart.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var footerView = UIView(frame: CGRect(x: 0, y: 0, width: lineChart.frame.width, height: 16))
        
        print("viewDidLoad: \(lineChart.frame.width)")
        var footer1 = UILabel(frame: CGRect(x: 0, y: 0, width: lineChart.frame.width/2 - 8, height: 16))
        footer1.textColor = UIColor.white
        footer1.text = "\(chartLegend[0])"
        var footer2 = UILabel(frame: CGRect(x: lineChart.frame.width/2 - 8, y: 0, width: lineChart.frame.width/2 - 8, height: 16))
        footer2.textColor = UIColor.white
        footer2.text = "\(chartLegend[chartLegend.count - 1])"
        footer2.textAlignment = NSTextAlignment.right
        footerView.addSubview(footer1)
        footerView.addSubview(footer2)
        
//        var header = UILabel(frame: CGRect(x: 0, y: 0, width: lineChart.frame.width, height: 50))
//        header.textColor = UIColor.white
//        header.font = UIFont.systemFont(ofSize: 24)
//        header.text = "Weather: San Jose, CA"
//        header.textAlignment = NSTextAlignment.center
        
        lineChart.footerView = footerView
//        lineChart.headerView = header
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lineChart.reloadData()
        var timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(JBLineChartViewController.showChart), userInfo: nil, repeats: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hideChart()
    }
    
    func hideChart() {
        lineChart.setState(.collapsed, animated: true)
    }
    
    func showChart() {
        lineChart.setState(.expanded, animated: true)
    }
    
    // MARK: JBlineChartView
    
    func numberOfLines(in lineChartView: JBLineChartView!) -> UInt {
        return 1
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, numberOfVerticalValuesAtLineIndex lineIndex: UInt) -> UInt {
        return UInt(chartData.count)
        return 0
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, verticalValueForHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> CGFloat {
        
        return CGFloat(chartData[Int(horizontalIndex)])
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, colorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        return UIColor.lightGray
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, showsDotsForLineAtLineIndex lineIndex: UInt) -> Bool {
        return true
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, colorForDotAtHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> UIColor! {
        return UIColor.lightGray
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, smoothLineAtLineIndex lineIndex: UInt) -> Bool {
        return false
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, didSelectLineAt lineIndex: UInt, horizontalIndex: UInt) {
        
        let data = chartData[Int(horizontalIndex)]
        let key = chartLegend[Int(horizontalIndex)]
    }
    
    func didDeselectLine(in lineChartView: JBLineChartView!) {
        
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, fillColorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
       
        return UIColor.clear
    }
}

