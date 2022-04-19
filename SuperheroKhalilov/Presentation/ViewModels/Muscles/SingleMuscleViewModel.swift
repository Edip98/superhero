//
//  SingleMuscleViewModel.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 14.04.2022.
//

import Foundation

class SingleMuscleViewModel {
    
    let expandImage = "Expand"
    let selectedlabelText = "Selected:"
    
    let muscleName: String
    var exercises: [ExerciseViewModel] = []
    
    var isOpened = false
    var selectedExercisesCounter: String {
        String(exercises.filter { $0.isSelected }.count)
    }
    
    
    init(muscleName: String, exercises: [Exercise]) {
        self.muscleName = muscleName
        
        guard !exercises.isEmpty else { return }
        self.exercises = createExerciseViewModel(from: exercises)
    }
    
    private func createExerciseViewModel(from exerciseModel: [Exercise]) -> [ExerciseViewModel] {
        return exerciseModel.map { exercise in
            ExerciseViewModel(exercise)
        }
    }
}
