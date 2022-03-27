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
    
    func showParametersViewController(viewModel: ProfileViewModel, viewController: ProfileViewController) {
        let bodyParameterViewControler = BodyParameterViewController.instantiate()
        bodyParameterViewControler.viewModel = viewModel
        bodyParameterViewControler.delegate = viewController
        bodyParameterViewControler.transitioningDelegate = viewController.transition
        bodyParameterViewControler.modalPresentationStyle = .custom
        viewController.present(bodyParameterViewControler, animated: true)
    }
}
