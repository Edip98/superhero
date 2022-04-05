//
//  ProfileTableCell.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 10.03.2022.
//

import UIKit

protocol ProfileTableCellDelegate: AnyObject {
    func shouldChangeCharactersIn()
    func textFieldShouldReturn(textField: UITextField, bodyParameterViewModel: BodyParameterViewModel)
    func keyboardWillShow(sender: NSNotification)
    func keyboardWillHide(sender: NSNotification)
}

class ProfileTableCell: UITableViewCell {
    
    @IBOutlet weak var parameterLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var measurementLabel: UILabel!
    @IBOutlet weak var textFieldUnderLineView: UIView!
    @IBOutlet weak var parameterSwitch: UISwitch!
    
    static let identifier = "ProfileTableCell"
    
    var bodyParameterViewModel: BodyParameterViewModel!
    
    weak var delegate: ProfileTableCellDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
        textLabel?.textColor = .white
        setDoneOnKeyboard()
        registerKeyboardNotification()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ProfileTableCell", bundle: nil)
    }
    
    func configure(with viewModel: BodyParameterViewModel) {
        bodyParameterViewModel = viewModel
        
        parameterLabel.text = viewModel.bodyPart
        parameterLabel.textColor = .white
        parameterLabel.numberOfLines = 2
        
        valueTextField.text = String(viewModel.value)
        valueTextField.textColor = .customGray
        valueTextField.borderStyle = .none
        valueTextField.returnKeyType = .done
        valueTextField.keyboardType = .numberPad
        valueTextField.textColor = UIColor.customGray
        valueTextField.font = UIFont(name: UIFont.helveticaNeue, size: 18)
        valueTextField.delegate = self
        
        textFieldUnderLineView.backgroundColor = .customYellow
        
        if parameterLabel.text == "Weight" {
            measurementLabel.text = "kg"
        }
        
        measurementLabel.textColor = UIColor.customGray
        measurementLabel.font = UIFont(name: UIFont.helveticaNeue, size: 18)
        
        parameterSwitch.thumbTintColor = .white
        parameterSwitch.onTintColor = .customYellow
        parameterSwitch.addTarget(self, action: #selector(switchToggle), for: .touchUpInside)
    }
    
    @objc func switchToggle() {
        if !parameterSwitch.isOn {
            textFieldUnderLineView.backgroundColor = .customGray
        } else {
            textFieldUnderLineView.backgroundColor = .customYellow
        }
    }
    
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(textFieldShouldReturn))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        valueTextField.inputAccessoryView = keyboardToolbar
    }
    
    func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        delegate.keyboardWillShow(sender: sender)
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        delegate.keyboardWillHide(sender: sender)
    }
}

extension ProfileTableCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if valueTextField.text == "0" {
            valueTextField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate.textFieldShouldReturn(textField: valueTextField, bodyParameterViewModel: bodyParameterViewModel)
        endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        delegate.shouldChangeCharactersIn()
        return true
    }
}

extension UIResponder {

    private struct Static {
        static weak var responder: UIResponder?
    }

    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }

    @objc private func _trap() {
        Static.responder = self
    }
}
