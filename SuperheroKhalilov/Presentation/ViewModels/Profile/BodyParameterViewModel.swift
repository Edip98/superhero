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
    var changeValue: Int16
    var isOn: Bool
    var color: UIColor
    var changeValueText: String {
        get {
            if changeValue == 0 {
                return ""
            } else {
                return changeValue > 0 ? "+\(changeValue)" : "\(changeValue)"
            }
        }
    }
    
    var dateArray: [Date]
    var valueArray: [Int16]

    init(model: BodyParameter) {
        bodyPart = model.bodyPart
        isSelected = model.isSelected
        changeValue = model.changeValue
        isOn = model.isOn
        dateArray = model.dateArray
        valueArray = model.valueArray
        
        if changeValue < 0 {
            color = .customRed
        } else {
            color = .customGreen
        }
        
        if changeValue == 0 {
            color = .clear
        }
    }
    
    func addValue(_ newValue: Int) {
        
        let valueToAdd = Int16(newValue)
        
        let currentDate = Date()

        if dateArray.isEmpty {
            dateArray.append(currentDate)
            valueArray.append(valueToAdd)
        }
        
        changeValue = Int16(newValue) - (valueArray.last ?? 0)
        
        let order = Calendar.current.compare(currentDate, to: dateArray.last!, toGranularity: .second)
        
        switch order {
        case .orderedDescending:
            dateArray.append(currentDate)
            valueArray.append(valueToAdd)
        case .orderedSame:
            dateArray.removeLast()
            dateArray.append(currentDate)
            valueArray.removeLast()
            valueArray.append(valueToAdd)
        default:
            break
        }
    }
}
