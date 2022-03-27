//
//  BodyParameterCell.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 16.03.2022.
//

import UIKit

class BodyParameterCell: UITableViewCell {
    
    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var parameterLabel: UILabel!
    
    static let identifier = "BodyParameterCell"
    
    var isCheckboxSelected = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .black
        selectionStyle = .none
        textLabel?.font = UIFont(name: UIFont.sairaRegular, size: 18)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "BodyParameterCell", bundle: nil)
    }
    
    func configure(with viewModel: BodyParameterViewModel?) {
        parameterLabel?.text = viewModel?.bodyPart
        parameterLabel.textColor = .white
        parameterLabel.font = UIFont.systemFont(ofSize: 18)
        
        if viewModel?.isSelected == true {
            checkboxImageView.image = UIImage(named: "Checkbox")
        } else {
            checkboxImageView.image = nil
        }
        checkboxImageView.contentMode = .scaleToFill
        checkboxImageView.layer.borderWidth = 1
        checkboxImageView.layer.borderColor = UIColor.customYellow.cgColor
        checkboxImageView.layer.cornerRadius = 2
    }
}
