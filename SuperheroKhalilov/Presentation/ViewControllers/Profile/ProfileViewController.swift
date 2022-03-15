//
//  ProfileViewController.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 10.03.2022.
//

import UIKit

class ProfileViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var profileBackgroundImage: UIImageView!
    @IBOutlet weak var profileImageOpacity: UIView!
    @IBOutlet weak var profileTable: UITableView!
    @IBOutlet weak var addOptionsButton: UIButton!
    @IBOutlet weak var addButtonView: UIView!
    
    var coordinator: MainCoordinator?
    var profileViewModel = ProfileViewModel()
    var profileHeaderView = ProfileHeaderView()
    var profileFooterView = ProfileFooterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: profileViewModel.rightBarButtonItemTitle, style: .plain, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem?.isEnabled = false
        configureBackgroundImage()
        configureTableView()
        configureButton()
        profileHeaderView.nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileHeaderView.nameTextField.text =  profileViewModel.profile?.name
         
        if profileHeaderView.nameTextField.hasText {
            profileHeaderView.textFieldUnderline.backgroundColor = .lightYellow
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            profileHeaderView.textFieldUnderline.backgroundColor = .white
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.hasText {
            navigationItem.rightBarButtonItem?.isEnabled = true
            profileHeaderView.textFieldUnderline.backgroundColor = .lightYellow
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
            profileHeaderView.textFieldUnderline.backgroundColor = .white
        }
    }
    
    @objc func saveButtonPressed() {
        profileViewModel.profile?.name = profileHeaderView.nameTextField.text
        ProfileManager.sharedInstance.saveProfile()
        coordinator?.back()
    }
    
    func configureTableView() {
        profileTable.register(ProfileTableCell.nib(), forCellReuseIdentifier: ProfileTableCell.identifier)
        profileTable.dataSource = self
        profileTable.delegate = self
        profileTable.backgroundColor = .clear
        profileTable.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
    }
    
    func configureButton() {
        addOptionsButton.backgroundColor = .lightYellow
        addOptionsButton.titleLabel?.font = UIFont(name: UIFont.sairaRegular, size: 16)
        addOptionsButton.layer.cornerRadius = 25
        addOptionsButton.titleLabel?.textColor = .black

        addButtonView.backgroundColor = .black
    }

    func configureBackgroundImage() {
        if profileViewModel.profile?.sex == "SUPERMAN" {
            profileBackgroundImage.image = UIImage(named: profileViewModel.supermanBackgroundImageName)
        }
        else {
            profileBackgroundImage.image = UIImage(named: profileViewModel.supergirlBackgroundImageName)
        }
        profileBackgroundImage.addBlackGradientLayerInForeground(
            frame: profileBackgroundImage.bounds,
            colors: [.black.withAlphaComponent(1), .black.withAlphaComponent(0.83), .black.withAlphaComponent(0.0)],
            startPoint: .init(x: 0.5, y: 1.0),
            endPoint: .init(x: 0.5, y: 0.0)
        )
        profileBackgroundImage.contentMode = .scaleToFill
        profileImageOpacity.backgroundColor = .black.withAlphaComponent(0.6)
    }
}


extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = profileTable.dequeueReusableCell(withIdentifier: ProfileTableCell.identifier, for: indexPath) as? ProfileTableCell else { return UITableViewCell() }
        cell.optionLabel.text = "Option \(indexPath.row)"
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        profileTable.deselectRow(at: indexPath, animated: true)
    }
}
