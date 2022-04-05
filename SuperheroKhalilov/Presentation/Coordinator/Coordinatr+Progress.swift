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
    
    func presentProgressChartVC(title: String, bodyName: String) {
        let vc = ProgressChartViewController.instantiate()
        vc.coordinator = self
        vc.title = title
        vc.bodyNameLabelText = bodyName
        navigationController.pushViewController(vc, animated: true)
    }
}

