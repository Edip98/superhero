//
//  BodyParameterViewModel.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 16.03.2022.
//

import Foundation
import UIKit

class BodyParameterViewModel {
    
    var bodyPart: String?
    var isSelected: Bool
    var value: Int16
    var changeValue: Int16
    var isOn: Bool
    var color: UIColor
    var changeValueText: String

    init(model: BodyParameter) {
        bodyPart = model.bodyPart
        isSelected = model.isSelected
        value = model.value
        changeValue = model.changeValue
        isOn = model.isOn
        if changeValue < 0 {
            color = .systemRed
            changeValueText = String(changeValue)
        } else {
            color = .systemGreen
            changeValueText = "+\(changeValue)"
        }
        if changeValue == value {
            color = .clear
            changeValueText = ""
        }
    }
    
    func calculateProgress(_ newValue: Int) {
        changeValue = Int16(newValue) - value
    }
}
