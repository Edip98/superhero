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
    func switchToggle(parameterSwitch: UISwitch, textFieldUnderLineView: UIView, bodyParameterViewModel: BodyParameterViewModel)
    func keyboardWillShow(sender: NSNotification)
    func keyboardWillHide(sender: NSNotification)
    func checkTextFieldsValue(textField: UITextField, textFieldUnderLine: UIView, index: Int)
}

class ProfileTableCell: UITableViewCell {
    
    @IBOutlet weak var parameterLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var measurementLabel: UILabel!
    @IBOutlet weak var textFieldUnderLineView: UIView!
    @IBOutlet weak var parameterSwitch: UISwitch!
    
    static let identifier = "ProfileTableCell"
    let maxLengthOfValueTextField = 3
    
    var bodyParameterViewModel: BodyParameterViewModel!
    var profileViewModel = ProfileViewModel()
    
    weak var delegate: ProfileTableCellDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        setDoneOnKeyboard()
        registerNotifications()
        configureParameterLabel()
        configureMeasurementLabel()
        connfigureValueTF()
        configureParameterSwitch()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ProfileTableCell", bundle: nil)
    }
    
    private func configureCell() {
        selectionStyle = .none
        backgroundColor = .clear
        textLabel?.textColor = .white
    }
    
    func configure(with viewModel: BodyParameterViewModel) {
        bodyParameterViewModel = viewModel
        parameterLabel.text = viewModel.bodyPart
        valueTextField.text = String(viewModel.value)
        parameterSwitch.isOn = viewModel.isOn
    }
    
    private func configureParameterLabel() {
        parameterLabel.textColor = .white
        parameterLabel.numberOfLines = 2

        if parameterLabel.text == "Weight" {
            measurementLabel.text = "kg"
        }
    }
    
    private func configureMeasurementLabel() {
        measurementLabel.textColor = UIColor.customGray
        measurementLabel.font = .font(name: .HelveticaNeue, size: 18)
    }
    
    private func connfigureValueTF() {
        valueTextField.textColor = .customGray
        valueTextField.borderStyle = .none
        valueTextField.returnKeyType = .done
        valueTextField.keyboardType = .numberPad
        valueTextField.textColor = UIColor.customGray
        valueTextField.font = .font(name: .HelveticaNeue, size: 18)
        valueTextField.tintColor = .white
        valueTextField.delegate = self
        
        textFieldUnderLineView.backgroundColor = .customGray
    }
    
    private func configureParameterSwitch() {
        parameterSwitch.thumbTintColor = .white
        parameterSwitch.onTintColor = .customYellow
        
        parameterSwitch.addTarget(self, action: #selector(switchToggle), for: .touchUpInside)
    }
    
    @objc func switchToggle(_ sender: UISwitch) {
        delegate.switchToggle(parameterSwitch: parameterSwitch, textFieldUnderLineView: textFieldUnderLineView, bodyParameterViewModel: bodyParameterViewModel)
    }
    
    private func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(textFieldShouldReturn))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        valueTextField.inputAccessoryView = keyboardToolbar
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(checkTextFieldsValue), name: Notification.Name("CheckTextFieldsValue"), object: nil)
    }
    
    @objc func checkTextFieldsValue() {
        delegate.checkTextFieldsValue(textField: valueTextField, textFieldUnderLine: textFieldUnderLineView, index: valueTextField.tag)
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
        if range.location > maxLengthOfValueTextField - 1 {
                textField.text?.removeLast()
            }
        delegate.shouldChangeCharactersIn()
        textFieldUnderLineView.backgroundColor = .customYellow
        return true
    }
}
