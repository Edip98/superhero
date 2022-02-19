//
//  HomeViewController.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 19.02.2022.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var homeBackgroundImage: UIImageView!
    
    var coordinator: MainCoordinator?
    
    var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setSexLabel()
        setBackgroundImages()
    }
    
    func setSexLabel() {
        sexLabel.text = homeViewModel.profile?.sex?.capitalized
        sexLabel.font = UIFont(name: "SairaRoman-Regular", size: 24)
        sexLabel.textColor = .white
    }
    
    func setBackgroundImages() {
        if sexLabel.text == "Superman" {
            homeBackgroundImage.image = UIImage(named: homeViewModel.supermanBackgroundImageName)
        } else {
            homeBackgroundImage.image = UIImage(named: homeViewModel.supergirlBackgroundImageName)
        }
        
        homeBackgroundImage.contentMode = .scaleAspectFill
        homeBackgroundImage.addBlackGradientLayerInForeground(
            frame: homeBackgroundImage.bounds,
            colors: [.black.withAlphaComponent(1), .black.withAlphaComponent(0.8), .black.withAlphaComponent(0.0)],
            startPoint: .init(x: 0.5, y: 1.0),
            endPoint: .init(x: 0.5, y: 0.0)
        )
    }
}
