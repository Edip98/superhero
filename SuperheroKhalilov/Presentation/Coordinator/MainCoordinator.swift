//
//  MainCoordinator.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 19.02.2022.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let startViewController = StartViewController.instantiate()
        startViewController.coordinator = self
        navigationController.pushViewController(startViewController, animated: false)
    }
}
