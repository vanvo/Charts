//
//  LineChart1ViewController.swift
//  ChartsDemo-iOS
//
//  Created by Jacob Christie on 2017-07-09.
//  Copyright © 2017 jc. All rights reserved.
//

import UIKit
import Charts

class LineChart1ViewController: DemoBaseViewController {
    
    @IBOutlet var chartView: LineChartView!
    
    struct XYAxis {
        let xAxis: Double
        let yAxis: Double
    }
    
    var xy: [XYAxis] = [XYAxis(xAxis: 0.0, yAxis: 14.4),
                       XYAxis(xAxis: 22.884336, yAxis: 14.4),
                       XYAxis(xAxis: 45.768673, yAxis: 14.4),
                       XYAxis(xAxis: 68.65301, yAxis: 14.4),
                       XYAxis(xAxis: 91.537346, yAxis: 14.5),
                       XYAxis(xAxis: 114.421684, yAxis: 14.5),
                       XYAxis(xAxis: 137.30602, yAxis: 14.7),
                       XYAxis(xAxis: 160.19035, yAxis: 14.6),
                       XYAxis(xAxis: 183.07469, yAxis: 14.6),
                       XYAxis(xAxis: 209.78403, yAxis: 14.6),
                       XYAxis(xAxis: 213.60902, yAxis: 14.6),
                       XYAxis(xAxis: 217.43404, yAxis: 14.6),
                       XYAxis(xAxis: 222.44443, yAxis: 14.6),
                       XYAxis(xAxis: 257.7492, yAxis: 14.5)]

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Line Chart 1"
        self.options = [.toggleValues,
                        .toggleFilled,
                        .toggleCircles,
                        .toggleCubic,
                        .toggleHorizontalCubic,
                        .toggleIcons,
                        .toggleStepped,
                        .toggleHighlight,
                        .toggleGradientLine,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .saveToGallery,
                        .togglePinchZoom,
                        .toggleAutoScaleMinMax,
                        .toggleData]

        chartView.delegate = self
        
        chartView.chartDescription.enabled = false
        chartView.dragEnabled = false
        chartView.dragXEnabled = true
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.zoom(scaleX: 2, scaleY: 1, x: 0, y: 0)
        chartView.rightAxis.enabled = false
        chartView.legend.form = .line

        let xAxis = chartView.xAxis
        xAxis.labelPosition = XAxis.LabelPosition.bottom
        xAxis.axisLineColor = .red
        xAxis.axisLineWidth = 10
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesBehindDataEnabled = true
        xAxis.drawGridLinesEnabled = true
        xAxis.gridLineWidth = 0.5
        xAxis.gridLineDashPhase = 0
        xAxis.axisMaxLabels = 10
        xAxis.valueFormatter = XAxisValueFormatter()

        let leftAxis = chartView.leftAxis
        
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = xy[xy.count - 1].yAxis + 5
        
        leftAxis.gridLineWidth = 0.5
        leftAxis.drawLimitLinesBehindDataEnabled = true
        leftAxis.drawGridLinesEnabled = true
        leftAxis.valueFormatter = LeftAxisValueFormatter()

        chartView.animate(xAxisDuration: 1)
        updateChartData()
    }
    
    class LeftAxisValueFormatter: AxisValueFormatter {
        let formatter = NumberFormatter()
        
        init() {
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 2
            formatter.numberStyle = .decimal
        }
        
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            guard let roundValue = formatter.string(from: value as NSNumber) else {
                return "\(value)m"
            }
            return "\(roundValue)m"
        }
    }
    
    class XAxisValueFormatter: AxisValueFormatter {
        let formatter = NumberFormatter()
        
        init() {
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 2
            formatter.numberStyle = .decimal
        }
        
        
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            guard let roundValue = formatter.string(from: value as NSNumber) else {
                return "\(value)m"
            }
            return "\(roundValue)m"
        }
    }

    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }

        self.setDataCount()
    }
    
    func setDataCount() {
        let values = xy.map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: i.xAxis, y: i.yAxis)
        }

        let borderColor = UIColor(red: 74/255, green: 162/255, blue: 152/255, alpha: 1)
        let fillColor = UIColor(red: 74/255, green: 162/255, blue: 152/255, alpha: 0.4)
        let dataSet = LineChartDataSet(entries: values)
        dataSet.label = nil
        dataSet.drawFilledEnabled = false
        dataSet.drawIconsEnabled = false
        dataSet.drawCirclesEnabled = false
        dataSet.gradientPositions = nil
        dataSet.lineWidth = 1
        dataSet.fillColor = borderColor
        dataSet.drawCircleHoleEnabled = false
        dataSet.valueFont = .systemFont(ofSize: 9)
        dataSet.formLineDashLengths = [5, 2.5]
        dataSet.formLineWidth = 1
        dataSet.formSize = 15
        dataSet.mode = .cubicBezier
        dataSet.drawValuesEnabled = false

        dataSet.fillAlpha = 1
        dataSet.fill = ColorFill(cgColor: fillColor.cgColor)
        dataSet.drawFilledEnabled = true

        let data = LineChartData(dataSet: dataSet)

        chartView.data = data
    }

    private func setup(_ dataSet: LineChartDataSet) {
        if dataSet.isDrawLineWithGradientEnabled {
            dataSet.lineDashLengths = nil
            dataSet.highlightLineDashLengths = nil
            dataSet.setColors(.black, .red, .white)
            dataSet.setCircleColor(.black)
            dataSet.gradientPositions = [0, 40, 100]
            dataSet.lineWidth = 1
            dataSet.circleRadius = 3
            dataSet.drawCircleHoleEnabled = false
            dataSet.valueFont = .systemFont(ofSize: 9)
            dataSet.formLineDashLengths = nil
            dataSet.formLineWidth = 1
            dataSet.formSize = 15
        } else {
            dataSet.drawCirclesEnabled = false
            dataSet.gradientPositions = nil
            dataSet.lineWidth = 1
            dataSet.fillColor = UIColor(red: 74/255, green: 162/255, blue: 152/255, alpha: 0.7)
            dataSet.drawCircleHoleEnabled = false
            dataSet.valueFont = .systemFont(ofSize: 9)
            dataSet.formLineDashLengths = [5, 2.5]
            dataSet.formLineWidth = 1
            dataSet.formSize = 15
            dataSet.mode = .cubicBezier
            dataSet.drawValuesEnabled = false
        }
    }

    override func optionTapped(_ option: Option) {
        guard let data = chartView.data else { return }

        switch option {
        case .toggleFilled:
            for case let set as LineChartDataSet in data {
                set.drawFilledEnabled = !set.drawFilledEnabled
            }
            chartView.setNeedsDisplay()

        case .toggleCircles:
            for case let set as LineChartDataSet in data {
                set.drawCirclesEnabled = !set.drawCirclesEnabled
            }
            chartView.setNeedsDisplay()

        case .toggleCubic:
            for case let set as LineChartDataSet in data {
                set.mode = (set.mode == .cubicBezier) ? .linear : .cubicBezier
            }
            chartView.setNeedsDisplay()

        case .toggleStepped:
            for case let set as LineChartDataSet in data {
                set.mode = (set.mode == .stepped) ? .linear : .stepped
            }
            chartView.setNeedsDisplay()

        case .toggleHorizontalCubic:
            for case let set as LineChartDataSet in data {
                set.mode = (set.mode == .cubicBezier) ? .horizontalBezier : .cubicBezier
            }
            chartView.setNeedsDisplay()
        case .toggleGradientLine:
            for set in chartView.data!.dataSets as! [LineChartDataSet] {
                set.isDrawLineWithGradientEnabled = !set.isDrawLineWithGradientEnabled
                setup(set)
            }
            chartView.setNeedsDisplay()
        default:
            super.handleOption(option, forChartView: chartView)
        }
    }
}
