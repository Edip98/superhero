//
//  ProgramsViewModel.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 22.02.2022.
//

import Foundation

class ProgramsViewModel {
    
    let navigationBarTitle = "Programs"
    let labelText = "Your Programs"
    let buttonTitle = "Create New Program"
    
    var programs: [ProgramModel] = ProgramManager.sharedInstance.programs
    
    func updatePrograms() {
        programs = ProgramManager.sharedInstance.programs
    }

    func createProgramViewModel() -> [CreateProgramViewModel] {
        return programs.map({ CreateProgramViewModel(mode: .edit(program: $0))})
    }
}
