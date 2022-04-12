//
//  BodyParametersStorage.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 17.03.2022.
//

import Foundation
import CoreData

class BodyParametersStorage {
    
    var parametersList = [BodyParameter]()
    
    let bodyPartsNames = ["Height",
                          "Weight",
                          "Neck",
                          "Shoulders",
                          "Left biceps",
                          "Right biceps",
                          "Left thigh",
                          "Right thigh",
                          "Right forearm",
                          "Left forearm",
                          "Chest",
                          "Left lower leg",
                          "Right lower leg",
                          "Left ankle",
                          "Right ankle"]
    
    func loadSampleParametersList() {
        let context = ProfileManager.sharedInstance.mainContext
        let entity = NSEntityDescription.entity(forEntityName: "BodyParameter", in: context)
        
        parametersList = bodyPartsNames.map({ bodyPartsName -> BodyParameter in
            let param = BodyParameter(entity: entity!, insertInto: context)
            param.bodyPart = bodyPartsName
            param.isSelected = false
            param.changeValue = 0
            param.isOn = false
            param.dateArray = []
            param.valueArray = []
            return param
        })
    }
    
    func fetchProfileParametersViewModel() -> [BodyParameterViewModel] {
        loadSampleParametersList()
        return parametersList.map { parameter -> BodyParameterViewModel in
            return BodyParameterViewModel(model: parameter)
        }
    }
}

