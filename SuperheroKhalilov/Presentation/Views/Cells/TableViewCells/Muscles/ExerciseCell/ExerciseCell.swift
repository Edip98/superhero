//
//  ExerciseCell.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 14.04.2022.
//

import UIKit

protocol MusclesTableCellDelegate {
    func update(cell: ExerciseCell)
}

class ExerciseCell: UITableViewCell {
    
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var barbellImageView: UIImageView!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var moreAboutButton: UIButton!
    @IBOutlet weak var selectedButton: UIButton!
    
    static let identifier = "ExerciseCell"
    private var exerciseViewModel: ExerciseViewModel?
    var coordinator: MainCoordinator?
    var delegate: MusclesTableCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        configureUI()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ExerciseCell", bundle: nil)
    }
    
    func configure(with viewModel: ExerciseViewModel, for mode: MusclesViewControllerMode) {
        self.exerciseViewModel = viewModel
        
        exerciseNameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.options
        
        barbellImageView.image = UIImage(named: viewModel.barbellImageName)
        moreAboutButton.setTitle(viewModel.moreAboutButtonText, for: .normal)
        selectedButton.setImage(UIImage(named: viewModel.selectedButtonImage), for: .normal)
        
        configuretSelectedCell()
        
        guard mode == .edit else { return }
        let tap = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        cellContentView.addGestureRecognizer(tap)
        moreAboutButton.isEnabled = false
    }
    
    func configureUI() {
        cellContentView.backgroundColor = .clear
        cellContentView.layer.cornerRadius = 8

        exerciseNameLabel.font = .font(name: .SairaRegular, size: 18)
        exerciseNameLabel.textColor = .white
        
        descriptionLabel.font = .font(name: .NunitoLight, size: 14)
        descriptionLabel.textColor = .customYellow
        
        moreAboutButton.semanticContentAttribute = .forceRightToLeft
        moreAboutButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        moreAboutButton.titleLabel?.font = .font(name: .NunitoLight, size: 16)
        moreAboutButton.setTitleColor(.customYellow, for: .normal)
        
        selectedButton.isHidden = true
    }
    
    @objc func cellTapped() {
        delegate?.update(cell: self)
    }
    
    private func configuretSelectedCell() {
        guard let exerciseViewModel = exerciseViewModel else { return }
        if  exerciseViewModel.isSelected {
            cellContentView.layer.borderWidth = 2
            cellContentView.layer.borderColor = UIColor.customYellow.cgColor
            selectedButton.isHidden = false
        } else {
            cellContentView.layer.borderWidth = 1
            cellContentView.layer.borderColor = UIColor.white.withAlphaComponent(0.4).cgColor
            selectedButton.isHidden = true
        }
    }
 
    @IBAction func moreAboutButtonAction(_ sender: UIButton) {
        guard let viewModel = exerciseViewModel else { return }
        coordinator?.presentExerciseVC(with: viewModel)
    }
}

