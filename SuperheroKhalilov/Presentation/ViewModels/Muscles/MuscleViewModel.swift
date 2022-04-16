//
//  MusclesViewModel.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 22.02.2022.
//

import Foundation

class MuscleViewModel {
    
    let navigationBarTitle = "Muscles"
    let rightBarButtonItemTitle = "Save"
    
    var exerciseStorage = ExerciseStorage()
    var singleMuscleViewModel: [SingleMuscleViewModel] = []

    init() {
        let muscleGroups = exerciseStorage.fetchExercisesByMyscleTypes()
        singleMuscleViewModel = createMuscleViewModel(from: muscleGroups)
    }
    
    private func createMuscleViewModel(from muscleModel: [Muscle]) -> [SingleMuscleViewModel] {
        return muscleModel.map { model in
            SingleMuscleViewModel(muscleName: model.muscleName, exercises: model.exercisesList)
        }
    }
}
