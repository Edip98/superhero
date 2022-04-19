//
//  MusclesSectionHeader.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 13.04.2022.
//

import UIKit

class MusclesSectionHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var headerContentView: UIView!
    @IBOutlet weak var muscleTypeLabel: UILabel!
    @IBOutlet weak var expandImageView: UIImageView!
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var selectedLabel: UILabel!
    @IBOutlet weak var countingLabel: UILabel!
    
    static let identifier = "MusclesSectionHeader"
    private var singleMuscleViewModel: SingleMuscleViewModel?
    var headerTappedHandler: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .clear
        configureUI()
    }

    func configure(with viewModel: SingleMuscleViewModel) {
        self.singleMuscleViewModel = viewModel
        
        muscleTypeLabel.text = viewModel.muscleName
        expandImageView.image = UIImage(named: viewModel.expandImage)
        selectedLabel.text = viewModel.selectedlabelText
        
        if !viewModel.isOpened {
            expandImageView.image = UIImage(named: viewModel.expandImage)
        } else {
            rotateImage()
        }
        
        numberOfSelectedExercises()
    }
    
    func configureUI() {
        headerContentView.backgroundColor = .clear
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        headerContentView.addGestureRecognizer(tap)
        
        muscleTypeLabel.textColor = .white
        muscleTypeLabel.font = .font(name: .HelveticaNeue, size: 18)
        
        underlineView.backgroundColor = .white
        
        selectedLabel.font = .font(name: .NunitoLight, size: 14)
        selectedLabel.textColor = .white
        
        countingLabel.font = .font(name: .NunitoSemiBold, size: 14)
        countingLabel.textColor = .customYellow
    }
    
    func numberOfSelectedExercises() {
        guard let amount = singleMuscleViewModel?.selectedExercisesCounter else { return }
        countingLabel.text = amount
        stackView.isHidden = Int(amount) == 0 ? true : false
    }
    
    @objc func headerTapped() {
        headerTappedHandler?()
        rotateImage()
    }
    
    func rotateImage() {
        expandImageView.transform = expandImageView.transform.rotated(by: .pi)
    }
}

