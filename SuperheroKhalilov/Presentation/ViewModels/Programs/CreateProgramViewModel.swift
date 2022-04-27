//
//  CreateProgramViewModel.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 19.04.2022.
//

import Foundation

enum ProgramMode {
    case create
    case edit(program: ProgramModel)
}

class CreateProgramViewModel {
    
    let navigationBarTitle = "Programs"
    let rightBarButtonItemTitle = "Save"
    var labelText = "Add Program"
    let nameTextFieldPlaceholderText = "Name"
    let descriptionTextFieldPlaceholderText = "Description"
    let alertTitle = "Programs has been added!"
    let alertImageName = "CheckmarkAccessory"
    

    var inputProgram: ProgramModel
    let originProgram: ProgramModel
    
    let exersiceViewModel: [ExerciseViewModel] = [ExerciseViewModel]()
    
    var mode: ProgramMode
    
    init(mode: ProgramMode) {
        self.mode = mode
        
        switch mode {
        case .create:
            inputProgram = ProgramModel(programID: UUID().uuidString, programName: "", programDescription: nil, exercises: [])
        case .edit(let program):
            labelText = program.programName
            inputProgram = program
            
        }
        originProgram = inputProgram
    }
    
    var isSaveButtonEnable: Bool {
        switch mode {
        case .create:
            return inputProgram.isEnabled
        case .edit:
            return inputProgram.isEnabled && inputProgram != originProgram
        }
    }
    
    func saveButtonTapped() {
        switch mode {
        case .create:
            ProgramManager.sharedInstance.saveProgram(inputProgram)
        case .edit:
            ProgramManager.sharedInstance.updateProgram(oldProgram: originProgram, newProgram: inputProgram)
        }
    }
    
    func changedName(_ text: String) {
        inputProgram.programName = text
    }
    
    func changedDescription(_ text: String) {
        inputProgram.programDescription = text
    }
    
    func changeExercises(_ exercises: [ExerciseViewModel]) {
        inputProgram.exercises = exercises
    }
}
