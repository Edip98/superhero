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
    
    func moveToProgram(with mode: ProgramMode) {
        let vc = CreateProgramViewContoller.instantiate()
        vc.coordinator = self
        switch mode {
        case .create:
            vc.createProgramViewModel = CreateProgramViewModel(mode: .create)
        case .edit(let program):
            vc.createProgramViewModel = CreateProgramViewModel(mode: .edit(program: program))
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
    func presentCreateProgramViewContoller(with mode: ProgramMode) {
        let vc = CreateProgramViewContoller.instantiate()
        vc.coordinator = self
        switch mode {
        case .create:
            vc.createProgramViewModel = CreateProgramViewModel(mode: .create)
        case .edit(let program):
            vc.createProgramViewModel = CreateProgramViewModel(mode: .edit(program: program))
        }
        navigationController.pushViewController(vc, animated: true)
    }
}
