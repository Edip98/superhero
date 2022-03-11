//
//  Coordinator+Profile.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 10.03.2022.
//

import Foundation

extension MainCoordinator {
    
    func presentProfileVC(title: String) {
        let vc = ProfileViewController.instantiate()
        vc.title = title
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
