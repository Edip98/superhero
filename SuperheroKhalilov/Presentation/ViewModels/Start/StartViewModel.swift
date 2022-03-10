//
//  StartViewModel.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 19.02.2022.
//

import Foundation

class StartViewModel {
    
    let maleButtonTitle = "SUPERMAN"
    let femaleButtonTitle = "SUPERGIRL"
    
    let supermanbackgroundImage = "SupermanStartImage"
    let supergirlbackgroundImage = "SupergirlStartImage"
    
    let superheroLabelText = "SUPERHERO"
    let chooseHeroLabel = "выберите героя"
    
    func createProfile(with name: String) {
        ProfileManager.sharedInstance.createDefaultProfile(with: name)
    }
}

