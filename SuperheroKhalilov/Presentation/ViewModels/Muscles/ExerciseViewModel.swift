//
//  ExerciseViewModel.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 14.04.2022.
//

import Foundation

class ExerciseViewModel {

    let navigationBarTitle = "Exersice"
    let barbellImageName = "Barbell"
    let moreAboutButtonText = "More about"
    let selectedButtonImage = "Selected"
    let addButtonTitle = "Add to Program"
    
    var isSelected = false
    
    let name: String
    let exerciseImage: String
    let descriptions: String
    let options: String
    
    init(_ model: Exercise) {
        name = model.name
        exerciseImage = model.exerciseImage
        descriptions = model.descriptions
        options = "\(model.equipment), \(model.level), \(model.exerciseType)"
    }
}
