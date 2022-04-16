//
//  ExerciseViewController.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 14.04.2022.
//

import Foundation
import UIKit

class ExerciseViewController: UIViewController, Storyboarded  {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var barbellImageView: UIImageView!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseExplanationLabel: UILabel!
    @IBOutlet weak var exerciseDescriptionLabel: UILabel!
    @IBOutlet weak var buttonContentView: UIView!
    @IBOutlet weak var addButton: CustomButton!
    
    var coordinator: MainCoordinator?
    var viewModel: ExerciseViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = viewModel?.navigationBarTitle
        contentView.backgroundColor = .black
        configureScrollView()
        convfigureBarbellImageView()
        cpnfigureExerciseNameLabel()
        configureExerciseDescriptionLabel()
        configureExerciseExplanationLabel()
        configureExerciseNameLabel()
        configureExerciseImageView()
        configureAddButton()
    }
    
    func configureAddButton() {
        addButton.setTitle(viewModel?.addButtonTitle, for: .normal)
        buttonContentView.backgroundColor = .clear
        buttonContentView.addBlackGradientLayerInBackground(
            frame: buttonContentView.bounds,
            colors: [.black.withAlphaComponent(1), .black.withAlphaComponent(0.7)],
            startPoint: .init(x: 0.5, y: 1.0),
            endPoint: .init(x: 0.5, y: 0.0)
        )
    }
    
    func configureExerciseNameLabel() {
        exerciseNameLabel.font = .font(name: .SairaLight, size: 16)
    }
    
    func configureExerciseExplanationLabel() {
        exerciseExplanationLabel.text = viewModel?.descriptions
        exerciseExplanationLabel.textColor = .customGray
    }
    
    func configureExerciseDescriptionLabel() {
        exerciseDescriptionLabel.text = viewModel?.options
        exerciseDescriptionLabel.font = .font(name: .NunitoLight, size: 14)
    }
    
    func cpnfigureExerciseNameLabel() {
        exerciseNameLabel.text = viewModel?.name
        exerciseNameLabel.font = .font(name: .SairaRegular, size: 18)
    }
    
    func convfigureBarbellImageView() {
        barbellImageView.image = UIImage(named: viewModel?.barbellImageName ?? "")
    }
    
    func configureExerciseImageView() {
        exerciseImageView.image = UIImage(named: viewModel?.exerciseImage ?? "")
        exerciseImageView.contentMode = .scaleAspectFill
    }
    
    func configureScrollView() {
        scrollView.backgroundColor = .black
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
    }
    
    @IBAction func addButtonAction(_ sender: CustomButton) {
        let alert = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Standart Program", style: .default, handler: { _ in
            print("Standart Program")
        }))

        alert.addAction(UIAlertAction(title: "Program 1", style: .default, handler: { _ in
            print("Program 1")
        }))
        
        alert.addAction(UIAlertAction(title: "Program 2", style: .default, handler: { _ in
            print("Program 2")
        }))
        
        alert.addAction(UIAlertAction(title: "Create New Program", style: .default, handler: { _ in
            print("Create New Program")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        present(alert, animated: true)
    }
}
