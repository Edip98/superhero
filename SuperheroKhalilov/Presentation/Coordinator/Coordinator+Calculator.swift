//
//  Coordinator+Calculator.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 10.03.2022.
//

import Foundation

extension MainCoordinator {
    
    func presentCalculatorVC(title: String) {
        let vc = CalculatorViewController.instantiate()
        vc.coordinator = self
        vc.title = title
        navigationController.pushViewController(vc, animated: true)
    }
}
