//
//  ProfileViewModel.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 22.02.2022.
//

import Foundation
import UIKit

class ProfileViewModel {
    
    let supermanBackgroundImageName = "SupermanProfileImage"
    let supergirlBackgroundImageName = "SupergirlProfileImage"
    let rightBarButtonItemTitle = "Save"
    let headerNameTitleText = "Name"
    let addParametersButtonText = "Add options"
    
    let profile = ProfileManager.sharedInstance.userProfile!
    var profileName: String?
    
    var bodyParametersStorage = BodyParametersStorage()
    
    var bodyParameteresViewModel = [BodyParameterViewModel]()
    private var parameterList: [BodyParameter] = []
    
    var selectedParameterViewModel = [BodyParameterViewModel]()
    
    init() {
        fetchParameters()
        check()
    }
    
    func fetchParameters() {
        profileName = profile.name
        bodyParameteresViewModel = bodyParametersStorage.fetchProfileParametersViewModel()
        parameterList = Array(_immutableCocoaArray: profile.parameters!)
        
        if !parameterList.isEmpty {
            selectedParameterViewModel = parameterList.map({ parameters in
                createViewModel(with: parameters)
            })
        }
    }
    
    func createViewModel(with bodyParameter: BodyParameter) -> BodyParameterViewModel {
        let parameterViewModel = BodyParameterViewModel(model: bodyParameter)
        return parameterViewModel
    }
    
    func toggleIsSelected(at index: Int) {
        let selectedElement = bodyParameteresViewModel[index]
        
        if selectedElement.isSelected == false {
            selectedParameterViewModel.append(selectedElement)
            selectedElement.isSelected.toggle()
            
        } else if selectedElement.isSelected == true {
            if let deselect = selectedParameterViewModel.firstIndex(where: { $0.bodyPart == selectedElement.bodyPart }) {
                selectedParameterViewModel.remove(at: deselect)
                selectedElement.isSelected.toggle()
            }
        }
    }
    
    func remove(at index: Int) {
        selectedParameterViewModel.remove(at: index)
    }
    
    func check() {
      
        for viewModel in selectedParameterViewModel {
            if let model = bodyParametersStorage.parametersList.first(where: { $0.bodyPart == viewModel.bodyPart }) {
                model.isSelected = false
            }
        
        }
    }
    
    func saveParameters() {
        var params: [BodyParameter] = []
        
        for viewModel in selectedParameterViewModel {
            if let model = bodyParametersStorage.parametersList.first(where: { $0.bodyPart == viewModel.bodyPart }) {
                model.bodyPart = viewModel.bodyPart
                model.isSelected = viewModel.isSelected
                model.value = viewModel.value
                
                params.append(model)
            }
        }
        profile.parameters = NSOrderedSet(array: params)
        ProfileManager.sharedInstance.saveProfile()
    }
}
