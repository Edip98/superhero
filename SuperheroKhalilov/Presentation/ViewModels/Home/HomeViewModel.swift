//
//  HomeViewModel.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 19.02.2022.
//

import Foundation

class HomeViewModel {
    
    let supermanBackgroundImageName = "SupermanHomeImage"
    let supergirlBackgroundImageName = "SupergirlHomeImage"
    
    let profile = ProfileManager.sharedInstance.userProfile
    
    enum ViewControllersID: String {
        case profile = "ProfileViewController"
        case progress = "ProgressViewController"
        case programs = "ProgramsViewController"
        case calculator = "CalculatorViewController"
        case muscles = "MusclesViewController"
    }
    
    let mainItems = ["Профиль", "Прогресс", "Программы", "Калькулятор", "Мышцы"]
    private let viewControllersIDs: [ViewControllersID] = [.profile, .progress, .programs, .calculator, .muscles]
    
    
    func pushToViewController(at indexPath: IndexPath, coordinator: MainCoordinator?) {
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
}
