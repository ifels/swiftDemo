//
//  ViewController.swift
//  ChartsDemo
//
//  Created by 聂鑫鑫 on 16/11/18.
//  Copyright © 2016年 ifels. All rights reserved.
//

import UIKit
import SnapKit
import Charts

class ViewController: UIViewController {
    var chartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        title = "Charts Demo"
    }
    
    
    func setupViews(){
        let box = UIView()
        chartView = LineChartView()
        
        self.view.addSubview(box)
        self.view.addSubview(chartView)
        
        box.snp.makeConstraints{ make in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.top.equalTo(view).offset(10)
            make.bottom.equalTo(view).offset(-10)
        }
        
        chartView.snp.makeConstraints{ make in
            make.left.equalTo(box)
            make.right.equalTo(box)
            make.top.equalTo(box)
            make.bottom.equalTo(box)
        }
        
        
        updateChartWithData()
        
    }
    
    func updateChartWithData() {
        let values: [Double] = [8, 100, 81, 93, 52, 44, 97, 101, 75, 28,
                                76, 25, 20, 13, 52, 44, 57, 23, 45, 91, 1,
                                99, 14, 84, 48, 40, 71, 106, 41, 45, 61, 0]
        
        var entries: [ChartDataEntry] = Array()
        for (i, value) in values.enumerated() {
            entries.append(ChartDataEntry(x: Double(i), y: value))
        }
        
        let dataSet = LineChartDataSet(values: entries, label: "First unit test data")
        
        chartView.backgroundColor = NSUIColor.clear
        chartView.leftAxis.axisMinimum = 0.0
        chartView.rightAxis.axisMinimum = 0.0
        chartView.data = LineChartData(dataSet: dataSet)
        
        chartView.setScaleEnabled(false);
        chartView.dragEnabled = false
        chartView.minOffset = 0
        chartView.drawGridBackgroundEnabled = false;
        
        chartView.drawBordersEnabled = false
        chartView.drawMarkers = false
        
        chartView.chartDescription?.text = ""
        chartView.legend.enabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.xAxis.enabled = false
        
        let lfetYAxis = chartView.leftAxis
        
        lfetYAxis.axisMinimum = 0
        lfetYAxis.axisMaximum = 110
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

