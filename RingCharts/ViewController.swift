//
//  ViewController.swift
//  RingCharts
//
//  Created by iHub on 11/11/19.
//  Copyright © 2019 iHubTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import PieCharts

class ViewController: UIViewController,PieChartDelegate {

    @IBOutlet weak var chartView: PieChart!
    fileprivate static let alpha: CGFloat = 0.5
    
    let colors = [
        UIColor.yellow.withAlphaComponent(alpha),
        UIColor.green.withAlphaComponent(alpha),
        UIColor.purple.withAlphaComponent(alpha),
        UIColor.cyan.withAlphaComponent(alpha),
        UIColor.darkGray.withAlphaComponent(alpha),
        UIColor.red.withAlphaComponent(alpha),
        UIColor.magenta.withAlphaComponent(alpha),
        UIColor.orange.withAlphaComponent(alpha),
        UIColor.brown.withAlphaComponent(alpha),
        UIColor.lightGray.withAlphaComponent(alpha),
        UIColor.gray.withAlphaComponent(alpha),
    ]
    fileprivate var currentColorIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartView.layers = [createPlainTextLayer(), createTextWithLinesLayer()]
        chartView.delegate = self
        chartView.models = createModels() // order is important - models have to be set at the end
        
    }

    // MARK: - PieChartDelegate
    
    func onSelected(slice: PieSlice, selected: Bool) {
        print("Selected: \(selected), slice: \(slice)")
    }
    
    // MARK: - Models
    
    fileprivate func createModels() -> [PieSliceModel] {
        
        let models = [
            PieSliceModel(value: 12, color: colors[0]),
            PieSliceModel(value: 4, color: colors[1]),
            PieSliceModel(value: 8, color: colors[2]),
            PieSliceModel(value: 6, color: colors[4]),
        ]
        
        currentColorIndex = models.count
        return models
    }
    
    // MARK: - Layers
    
    fileprivate func createPlainTextLayer() -> PiePlainTextLayer {
        
        let textLayerSettings = PiePlainTextLayerSettings()
        textLayerSettings.viewRadius = 55
        textLayerSettings.hideOnOverflow = true
        textLayerSettings.label.font = UIFont.systemFont(ofSize: 8)
        textLayerSettings.label.textColor = UIColor.clear
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        textLayerSettings.label.textGenerator = {slice in
            return formatter.string(from: slice.data.percentage * 100 as NSNumber).map{"\($0)%"} ?? ""
        }
        
        let textLayer = PiePlainTextLayer()
        textLayer.settings = textLayerSettings
        return textLayer
    }
    
    fileprivate func createTextWithLinesLayer() -> PieLineTextLayer {
        let lineTextLayer = PieLineTextLayer()
        var lineTextLayerSettings = PieLineTextLayerSettings()
        lineTextLayerSettings.lineColor = UIColor.white
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        lineTextLayerSettings.label.font = UIFont.systemFont(ofSize: 14)
        lineTextLayerSettings.label.textGenerator = {slice in
            
            print("Value:\(slice.hashValue)")
            
            if slice.hashValue == 0 {
                return formatter.string(from: slice.data.model.value as NSNumber).map{"Nikhil \($0)"} ?? ""
                
            }else if slice.hashValue == 1 {
                return formatter.string(from: slice.data.model.value as NSNumber).map{"Charan \($0)"} ?? ""
                
            }else if slice.hashValue == 2 {
                return formatter.string(from: slice.data.model.value as NSNumber).map{"Nivas \($0)"} ?? ""
                
            }else {
                return formatter.string(from: slice.data.model.value as NSNumber).map{"Naresh \($0)"} ?? ""
            }
            
            
        }
        
        lineTextLayer.settings = lineTextLayerSettings
        return lineTextLayer
    }
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
    }
}
