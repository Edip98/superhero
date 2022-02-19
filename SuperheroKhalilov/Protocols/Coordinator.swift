//
//  Coordinator.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 19.02.2022.
//

import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController { get set }
    
    func start()
}
