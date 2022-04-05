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
    let chart = "Chart"
    let textLabelText = "Displaying dynamics relative to data from \("31.03.2021")"
    
    var bodyParameterEntity = [BodyParameter]()
    var bodyParameterViewModel = [BodyParameterViewModel]()
    
    init() {
        fetchParameters()
    }
    
    func fetchParameters() {
        guard let parameters = profile?.parameters else { return }
        bodyParameterEntity = Array(_immutableCocoaArray: parameters)
        bodyParameterViewModel = bodyParameterEntity.filter { $0.isOn }
        .map { BodyParameterViewModel(model: $0) }
    }
    
    func presentProgressAlert(view: UIView) {
        let myView = ProgressAlertView()
        myView.center = view.center
        view.addSubview(myView)
    }
}
