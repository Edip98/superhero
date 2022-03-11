//
//  Coordinator+Programs.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 10.03.2022.
//

import Foundation

extension MainCoordinator {
    
    func presentProgramsVC(title: String) {
        let vc = ProgramsViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
