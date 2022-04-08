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
    
    let measurementLabelText = "cm"
    var chart = "Chart"
    let textLabelText = "Displaying dynamics relative to data from"

    var bodyParameterEntity = [BodyParameter]()
    var bodyParameterViewModel = [BodyParameterViewModel]()
    
    init() {
        fetchParameters()
    }
    
    func createDataEntries() -> [BarChartEntry] {
        
        bodyParameterViewModel.map { parameter in
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM"
            let date = formatter.string(from: parameter.dateArray.first ?? Date())
            
            return BarChartEntry(
                progressValue: parameter.changeValueText,
                progressBackgroundColor: parameter.color,
                value: String(parameter.value),
                height: Float(parameter.value),
                color: .customYellow,
                date: date)
        }
    }

    func fetchParameters() {
        guard let parameters = profile?.parameters else { return }
        bodyParameterEntity = Array(_immutableCocoaArray: parameters)
        bodyParameterViewModel = bodyParameterEntity.filter { $0.isSelected }
        .map { BodyParameterViewModel(model: $0) }
    }
    
    func presentProgressAlertView(view: UIView) {
        let myView = ProgressAlertView()
        myView.center = view.center
        view.addSubview(myView)
    }
}



