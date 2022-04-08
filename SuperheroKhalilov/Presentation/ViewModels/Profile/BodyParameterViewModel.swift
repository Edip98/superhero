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
    
    var dateArray: [Date]
    var valueArray: [Int16]

    init(model: BodyParameter) {
        bodyPart = model.bodyPart
        isSelected = model.isSelected
        value = model.value
        changeValue = model.changeValue
        isOn = model.isOn
        dateArray = model.dateArray
        valueArray = model.valueArray
        
        if changeValue < 0 {
            color = .customRed
            changeValueText = String(changeValue)
        } else {
            color = .customGreen
            changeValueText = "+\(changeValue)"
        }
        if changeValue == value {
            color = .clear
            changeValueText = ""
        }
    }
    
    
    func addValue(_ newValue: Int) {
        changeValue = Int16(newValue) - value
        
        let currentDate = Date()

        if dateArray.isEmpty || value == 0 {
            dateArray.append(currentDate)
            valueArray.append(value)
        }
        
        let order = Calendar.current.compare(currentDate, to: dateArray.last!, toGranularity: .second)
        
        switch order {
        case .orderedDescending:
            dateArray.append(currentDate)
            valueArray.append(value)
        case .orderedSame:
            dateArray.removeLast()
            dateArray.append(currentDate)
            valueArray.removeLast()
            valueArray.append(value)
        default:
            break
        }
    }
}
