//
//  ProgressViewModel.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 22.02.2022.
//

import Foundation
import UIKit

class ProgressViewModel {
    
    let profile = ProfileManager.sharedInstance.userProfile
    
    let alertLabelText = "Options are not selected. \nTo display them, add them \nto your profile."
    let alertImageName = "DetailAccessory"

    let descriptionText = "Displaying dynamics relative to data from"

    var bodyParameterEntity = [BodyParameter]()
    var bodyParameterViewModel = [BodyParameterViewModel]()
    
    var diagramData: BodyParameterViewModel?
    
    init() {
        fetchParameters()
    }
    
    func createDataEntries() -> [BarChartEntry]? {
        
        var chart: [BarChartEntry] = []
        
        guard let diagramData = diagramData else { return nil }
        
        let diagramValueCount = diagramData.valueArray
        
        for i in 0..<diagramValueCount.count {
            
            var progressValue = i == 0 ? "" : "\(diagramData.valueArray[i] - diagramData.valueArray[i - 1])"
            var progressColor: UIColor = .clear
            
            if Int(progressValue) ?? 0 > 0 {
                progressValue = "+\(diagramData.valueArray[i] - diagramData.valueArray[i - 1])"
            }
            
            if i > 0 {
                progressColor = diagramData.valueArray[i] - diagramData.valueArray[i - 1] > 0 ? .customGreen : .customRed
            }
            chart.append(BarChartEntry(progressValue: progressValue,
                                       progressBackgroundColor: progressColor,
                                       value: String(diagramData.valueArray[i]),
                                       height: Float(diagramData.valueArray[i]),
                                       color: .customYellow,
                                       date: diagramData.dateArray[i]))
        }
        return chart
    }
    
    func presentProgressAlertView(view: UIView) {
        let myView = ProgressAlertView()
        myView.center = view.center
        view.addSubview(myView)
    }
    
    func configureBodyNameLabel() -> String {
        guard let diagramData = diagramData, let bodyPart = diagramData.bodyPart else { return "" }
        let unit = bodyPart == "Weight" ? "kg" : "cm"
        return bodyPart + ", " + unit
    }
    
    func configureTitle() -> String {
        guard let diagramData = diagramData, let bodyPart = diagramData.bodyPart else { return "" }
        let chart = "Chart"
        return bodyPart + " " + chart
    }
    
    func configureDescriptionLabel() -> String {
        guard let diagramData = diagramData?.dateArray.first else { return "" }
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.YYYY"
        let date = dateFormater.string(from: diagramData)
        return descriptionText + " " + date
    }

    func fetchParameters() {
        guard let parameters = profile?.parameters else { return }
        bodyParameterEntity = Array(_immutableCocoaArray: parameters)
        bodyParameterViewModel = bodyParameterEntity
        .map { BodyParameterViewModel(model: $0) }
    }
}



