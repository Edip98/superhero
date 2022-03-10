//
//  Coordinator+Muscles.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 10.03.2022.
//

import Foundation

extension MainCoordinator {
    
    func presentMusclesVC(title: String) {
        let vc = MusclesViewController()
        vc.title = title
        vc.coordinator = self
        navigationController.isNavigationBarHidden = false
        navigationController.pushViewController(vc, animated: true)
    }
}
