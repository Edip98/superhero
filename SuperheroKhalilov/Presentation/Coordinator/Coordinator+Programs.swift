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
        vc.title = title
        navigationController.pushViewController(vc, animated: true)
    }
}
