//
//  ProfileViewController.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 10.03.2022.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var profileTable: UITableView!
    @IBOutlet weak var addOptionsButton: CustomButton!
    @IBOutlet weak var addButtonView: UIView!
    
    var coordinator: MainCoordinator?
    var profileViewModel = ProfileViewModel()
    var profileHeaderView = ProfileHeaderView()
    var profileFooterView = ProfileFooterView()
    
    let transition = PanelTransition()
    
    var tagsList = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: profileViewModel.rightBarButtonItemTitle, style: .plain, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem?.isEnabled = false
        configureTableView()
        configureButton()
        profileHeaderView.delegate = self
    }
    
    @objc func saveButtonPressed() {
        NotificationCenter.default.post(name: Notification.Name("CheckTextFieldsValue"), object: nil)
        if profileHeaderView.nameTextField.hasText && tagsList.count != 0 || profileHeaderView.cameraButtonHasChangedImage == true && tagsList.count != 0 {
            saveParametersAndBack()
        }
    }
    
    func configureTableView() {
        profileTable.register(ProfileTableCell.nib(), forCellReuseIdentifier: ProfileTableCell.identifier)
        profileTable.dataSource = self
        profileTable.delegate = self
        profileTable.backgroundColor = .clear
        profileTable.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
    }
    
    func configureButton() {
        addOptionsButton.setTitle(profileViewModel.addParametersButtonText, for: .normal)
        addOptionsButton.titleLabel?.font = .font(name: .SairaRegular, size: 16)
        
        addButtonView.addBlackGradientLayerInBackground(
            frame: addButtonView.bounds,
            colors: [.black, .black.withAlphaComponent(0.8)],
            startPoint: .init(x: 0.5, y: 1.0),
            endPoint: .init(x: 0.5, y: 0.0)
        )
    }
    
    @IBAction func addOptionsButtonPressed(_ sender: UIButton) {
        coordinator?.showParametersViewController(viewModel: profileViewModel, viewController: self)
    }
    
    func saveParametersAndBack() {
        profileViewModel.profile?.name = profileHeaderView.nameTextField.text
        profileViewModel.saveParameters()
        presentAlert(title: profileViewModel.alertTitle, image: profileViewModel.alertImage, numberOfLines: profileViewModel.alertTitleNumberOfLines, timeInterval: profileViewModel.alertTimeInterval, completion: {
            self.coordinator?.back()
        })
    }
}


extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileViewModel.selectedParameterViewModel.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = profileTable.dequeueReusableCell(withIdentifier: ProfileTableCell.identifier, for: indexPath) as? ProfileTableCell else { return UITableViewCell() }
        cell.configure(with: profileViewModel.selectedParameterViewModel[indexPath.row])
        cell.delegate = self
        navigationItem.rightBarButtonItem?.isEnabled = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return profileHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 301
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return profileFooterView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 51
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            profileViewModel.remove(at: indexPath.row)
            profileTable.deleteRows(at: [indexPath], with: .automatic)
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
}

extension ProfileViewController: ProfileTableCellDelegate {
    
    func checkTextFieldsValue(textField: UITextField, textFieldUnderLine: UIView, index: Int, bodyParameterViewModel: BodyParameterViewModel) {
        
        tagsList.append(index)
        
        if textField.text == "0" {
            textFieldUnderLine.backgroundColor = .red
            tagsList.removeAll()
        } else if tagsList.count == profileViewModel.selectedParameterViewModel.count || profileViewModel.selectedParameterViewModel.count == 0 {
            saveParametersAndBack()
        }
    }
     
    func textFieldShouldReturn(textField: UITextField) {
        navigationItem.rightBarButtonItem?.isEnabled = false
        if textField.text == "" {
            textField.text = "0"
        } else if textField.hasText {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    func shouldChangeCharactersIn() {
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func switchToggle(parameterSwitch: UISwitch, textFieldUnderLineView: UIView, bodyParameterViewModel: BodyParameterViewModel) {
        bodyParameterViewModel.isOn = parameterSwitch.isOn
        navigationItem.rightBarButtonItem?.isEnabled = true
        if !parameterSwitch.isOn {
            textFieldUnderLineView.backgroundColor = .customGray
        } else {
            textFieldUnderLineView.backgroundColor = .customYellow
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -0.5
            profileTable.frame.origin.y = newFrameY
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        profileTable.frame.origin.y = 0
    }
}

extension ProfileViewController: ProfileHeaderViewDelegate {
    
    func handleTextFieldDidChange(nameTextField: UITextField, textFieldUnderline: UIView) {
        nameTextField.text?.capitalizeFirstLetter()
        
        if !nameTextField.hasText {
            textFieldUnderline.backgroundColor = .white
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            textFieldUnderline.backgroundColor = .customYellow
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    func didTapOnCameraButton(view: UIView, button: UIButton) {
        let alert = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Add Avatar", style: .default, handler: { _ in
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            vc.delegate = view as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            vc.allowsEditing = true
            self.present(vc, animated: true, completion: nil)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Remove Avatar", style: .destructive, handler: { _ in
            ProfileManager.sharedInstance.userProfile?.image?.removeAll()
            button.setImage(UIImage(named: "Camera"), for: .normal)
            self.profileHeaderView.cameraButtonHasChangedImage = true
            button.layer.borderWidth = 0
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    
    func didFinishPickingMediaWithInfo(cameraButton: UIButton, profileImage: UIImage) {
        cameraButton.setImage(profileImage, for: .normal)
        profileHeaderView.cameraButtonHasChangedImage = true
        ProfileManager.sharedInstance.userProfile?.image = profileImage.pngData()
        cameraButton.layer.borderWidth = 1
        cameraButton.layer.borderColor = UIColor.customYellow.cgColor
        cameraButton.clipsToBounds = true
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
}

extension ProfileViewController: BodyParameterViewControllerDelegate {
    
    func didTapOnCancelButton() {
        coordinator?.dismiss(animated: true)
    }
    
    func didTapOnSelectButton() {
        if !profileViewModel.selectedParameterViewModel.isEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
        self.profileTable.reloadData()
        coordinator?.dismiss(animated: true)
    }
}
