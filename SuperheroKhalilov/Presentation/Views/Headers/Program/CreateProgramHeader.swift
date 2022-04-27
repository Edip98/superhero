//
//  CreateProgramHeader.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 20.04.2022.
//

import Foundation
import UIKit

protocol CreateProgramHeaderDelegate {
    func nameTFEditingChanged(_ text: String)
    func descriptionTFEditingChanged(_ text: String)
}

class CreateProgramHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var nameTextFieldUnderLineView: UIView!
    @IBOutlet weak var descriptionNameTextFieldUnderLineView: UIView!
    
    static let identifier = "CreateProgramHeader"
    let createProgramViewModel = CreateProgramViewModel(mode: .create)
    var delegate: CreateProgramHeaderDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .clear
        configureNameTextField()
        configureDescriptionTextField()
    }
    
    func configure(with viewModel: CreateProgramViewModel) {
        label.text = viewModel.labelText
        nameLabel.text = viewModel.nameTextFieldPlaceholderText
        descriptionLabel.text = viewModel.descriptionTextFieldPlaceholderText
    }

    func configureNameTextField() {
        nameTextField.backgroundColor = .clear
        nameTextField.textColor = .white
        nameTextField.font = .font(name: .HelveticaNeue, size: 18)
        nameTextField.autocapitalizationType = .sentences
        nameTextField.tintColor = .white
        nameTextField.autocorrectionType = .no
        nameTextField.attributedPlaceholder = NSAttributedString(
            string: createProgramViewModel.nameTextFieldPlaceholderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.customGray, .font : UIFont.font(name: .HelveticaNeueLight, size: 18)!]
        )
        nameTextField.delegate = self
    }
    
    func configureDescriptionTextField() {
        descriptionTextField.backgroundColor = .clear
        descriptionTextField.textColor = .white
        descriptionTextField.font = .font(name: .HelveticaNeue, size: 18)
        descriptionTextField.tintColor = .white
        descriptionTextField.autocorrectionType = .no
        descriptionTextField.autocapitalizationType = .sentences
        descriptionTextField.attributedPlaceholder = NSAttributedString(
            string: createProgramViewModel.descriptionTextFieldPlaceholderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.customGray, .font : UIFont.font(name: .HelveticaNeueLight, size: 18)!]
        )
        descriptionTextField.delegate = self
    }
    @IBAction func nameTFEditingChanged(_ sender: UITextField) {
        guard let text = sender.text, !text.isEmpty else { return }
        delegate?.nameTFEditingChanged(text)
    }
    @IBAction func descriptionTFEditingChanged(_ sender: UITextField) {
        guard let text = sender.text, !text.isEmpty else { return }
        delegate?.descriptionTFEditingChanged(text)
    }
}

extension CreateProgramHeader: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
