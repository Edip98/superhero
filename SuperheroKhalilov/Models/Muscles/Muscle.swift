//
//  Muscle.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 14.04.2022.
//

import Foundation

struct Muscle: Codable {
    let muscleName: String
    let exercisesList: [Exercise]
}

struct Exercise: Codable, Equatable {
    let name: String
    let imageIcon: String
    let exerciseImage: String
    let descriptions: String
    let exerciseType: String
    let equipment: String
    let level: String
}
