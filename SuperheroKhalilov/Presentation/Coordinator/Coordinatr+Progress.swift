//
//  Coordinatr+Progress.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 10.03.2022.
//

import Foundation

extension MainCoordinator {
    
    func presentProgressVC(title: String) {
        let vc = ProgressViewController.instantiate()
        vc.coordinator = self
        vc.title = title
        navigationController.pushViewController(vc, animated: true)
    }
    
    func presentProgressChartVC(paraemters: BodyParameterViewModel) {
        let vc = ProgressBarChartViewController.instantiate()
        vc.coordinator = self
        vc.progressViewModel.diagramData = paraemters
        navigationController.pushViewController(vc, animated: true)
    }
}

