//
//  CreateProgramCell.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 19.04.2022.
//

import UIKit

class CreateProgramCell: UITableViewCell {
    
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var barbellImageView: UIImageView!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var optionsLabel: UILabel!
    
    static let identifier = "CreateProgramCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        configureUI()
    }

    static func nib() -> UINib {
        return UINib(nibName: "CreateProgramCell", bundle: nil)
    }

    func configure(with model: ExerciseViewModel) {
        exerciseNameLabel.text = model.name
        optionsLabel.text = model.options
    }
    
    func configureUI() {
        cellContentView.backgroundColor = .clear
        
        barbellImageView.image = UIImage(named: "Barbell")
        
        exerciseNameLabel.textColor = .white
        exerciseNameLabel.font = .font(name: .SairaRegular, size: 18)
        
        optionsLabel.textColor = .customYellow
        optionsLabel.font = .font(name: .NunitoLight, size: 14)
    }
}
