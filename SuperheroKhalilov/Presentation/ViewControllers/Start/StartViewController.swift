//
//  StartViewController.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 19.02.2022.
//

import UIKit

class StartViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var supermanImageView: UIImageView!
    @IBOutlet weak var supergirlImageView: UIImageView!
    @IBOutlet weak var supermanOpacityView: UIView!
    @IBOutlet weak var supergirlOpacityView: UIView!
    @IBOutlet weak var superheroLabelView: UIView!
    @IBOutlet weak var chooseHeroLabelView: UIView!
    @IBOutlet weak var superheroLabel: UILabel!
    @IBOutlet weak var chooseHeroLabel: UILabel!
    @IBOutlet weak var supermanButton: UIButton!
    @IBOutlet weak var supergirlButton: UIButton!
    
    var coordinator: MainCoordinator?
    
    var startViewModel = StartViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundImages()
        configureButtons()
        configurelabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    
    @IBAction func sexButtonsTapped(_ sender: UIButton) {
        startViewModel.createProfile(with: sender.titleLabel?.text ?? "")
        coordinator?.start()
    }
    
    func configurelabels() {
        superheroLabel.text = startViewModel.superheroLabelText
        superheroLabel.font = UIFont(name: UIFont.FuturaBold , size: 32)
        superheroLabel.textColor = .lightYellow
        
        chooseHeroLabel.text = startViewModel.chooseHeroLabel
        chooseHeroLabel.font = UIFont(name: UIFont.sairaRegular, size: 16)
        chooseHeroLabel.textColor = .white
        
        superheroLabelView.addBlackGradientLayerInBackground(
            frame: superheroLabelView.bounds,
            colors: [.black.withAlphaComponent(1), .black.withAlphaComponent(0.8), .black.withAlphaComponent(0.0)],
            startPoint: .init(x: 0.5, y: 1.0),
            endPoint: .init(x: 0.5, y: 0.0)
        )
        
        chooseHeroLabelView.addBlackGradientLayerInBackground(
            frame: chooseHeroLabelView.bounds,
            colors: [.black.withAlphaComponent(1), .black.withAlphaComponent(0.4), .black.withAlphaComponent(0.0)],
            startPoint: .init(x: 0.5, y: 0.0),
            endPoint: .init(x: 0.5, y: 1.0)
        )
    }
    
    func configureBackgroundImages() {
        supermanImageView.image = UIImage(named: startViewModel.supermanbackgroundImage)
        supergirlImageView.image = UIImage(named: startViewModel.supergirlbackgroundImage)
        
        supermanImageView.contentMode = .scaleToFill
        supergirlImageView.contentMode = .scaleToFill
        
        supermanOpacityView.backgroundColor = .black.withAlphaComponent(0.6)
        supergirlOpacityView.backgroundColor = .black.withAlphaComponent(0.6)
    }
    
    func configureButtons() {
        supermanButton.setTitle(startViewModel.maleButtonTitle.uppercased(), for: .normal)
        supergirlButton.setTitle(startViewModel.femaleButtonTitle.uppercased(), for: .normal)
        
        supermanButton.backgroundColor = .lightYellow
        supergirlButton.backgroundColor = .lightYellow
        
        supermanButton.rounded()
        supergirlButton.rounded()
    }
}
