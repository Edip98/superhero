//
//  HomeViewModel.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 19.02.2022.
//

import Foundation

class HomeViewModel {
    
    let profile = ProfileManager.sharedInstance.userProfile
    
    var bodyParameterEntity = [BodyParameter]()
    var bodyParameterViewModel = [BodyParameterViewModel]()

    enum ViewControllersID: String {
        case profile = "ProfileViewController"
        case progress = "ProgressViewController"
        case programs = "ProgramsViewController"
        case calculator = "CalculatorViewController"
        case muscles = "MusclesViewController"
    }
    
    let mainItems = ["Profile", "Progress", "Programs", "Calculator", "Muscles"]
    private let viewControllersIDs: [ViewControllersID] = [.profile, .progress, .programs, .calculator, .muscles]

    func pushToViewController(at indexPath: IndexPath, coordinator: MainCoordinator?, viewController: HomeViewController) {
        switch viewControllersIDs[indexPath.row] {
        case .profile:
            coordinator?.presentProfileVC(title: mainItems[indexPath.row])
        case .progress:
            coordinator?.presentProgressVC(title: mainItems[indexPath.row])
        case .programs:
            coordinator?.presentProgramsVC(title: mainItems[indexPath.row])
        case .calculator:
            coordinator?.presentCalculatorVC(title: mainItems[indexPath.row])
        case .muscles:
            coordinator?.presentMusclesVC(title: mainItems[indexPath.row])
        }
    }
    
    func updateViewModel() {
        guard let parameters = profile?.parameters else { return }
        bodyParameterEntity = Array(_immutableCocoaArray: parameters)
        bodyParameterViewModel = bodyParameterEntity.filter { $0.isOn }
        .map { BodyParameterViewModel(model: $0) }
    }
}
