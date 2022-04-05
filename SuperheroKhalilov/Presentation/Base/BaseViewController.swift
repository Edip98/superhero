//
//  BaseViewController.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 19.02.2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    let backgroundImageView = UIImageView()
    let backgroundImageOpacityView = UIView()
    
    private let baseViewModel = BaseViewModel()
    
    private let profile = ProfileManager.sharedInstance.userProfile
    
    override func viewDidLoad() {
        configureBackgroundImage()
    }
    
    private func configureBackgroundImage() {
        view.insertSubview(backgroundImageView, at: 0)
        backgroundImageView.addSubview(backgroundImageOpacityView)
        backgroundImageView.frame = view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageOpacityView.frame = backgroundImageView.bounds
        backgroundImageOpacityView.backgroundColor = .black.withAlphaComponent(0.6)
        
        if profile?.sex == baseViewModel.superman {
            backgroundImageView.image = UIImage(named: baseViewModel.supermanBackgroundImageName)
        } else {
            backgroundImageView.image = UIImage(named: baseViewModel.supergirlBackgroundImageName)
        }
        
        backgroundImageView.addBlackGradientLayerInForeground(
            frame: backgroundImageView.bounds,
            colors: [.black.withAlphaComponent(1), .black.withAlphaComponent(0.8), .black.withAlphaComponent(0.0)],
            startPoint: .init(x: 0.5, y: 1.0),
            endPoint: .init(x: 0.5, y: 0.0)
        )
    }
}
