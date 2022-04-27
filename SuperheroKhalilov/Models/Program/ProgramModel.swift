//
//  ProgramModel.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 20.04.2022.
//

import Foundation

struct ProgramModel: Codable, Equatable {
    var programID: String
    var programName: String
    var programDescription: String?
    var exercises: [ExerciseViewModel]
    
    var isEnabled: Bool {
        return !programName.isEmpty && !exercises.isEmpty
    }
}
