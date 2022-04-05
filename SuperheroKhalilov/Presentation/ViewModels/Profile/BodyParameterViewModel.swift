//
//  BodyParameterViewModel.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 16.03.2022.
//

import Foundation

class BodyParameterViewModel {
    
    var bodyPart: String?
    var isSelected: Bool
    var value: Int16

    init(model: BodyParameter) {
        bodyPart = model.bodyPart
        isSelected = model.isSelected
        value = model.value
    }
}
