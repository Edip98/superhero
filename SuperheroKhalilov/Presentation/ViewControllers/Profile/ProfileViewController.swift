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
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textFieldUnderline: UIView!
    @IBOutlet weak var profileTable: UITableView!
    @IBOutlet weak var selectLabel: UILabel!
    @IBOutlet weak var addOptionsButton: UIButton!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    var coordinator: MainCoordinator?
    var profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: profileViewModel.rightBarButtonItemTitle, style: .plain, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem?.isEnabled = false
        configureBackgroundImage()
        configureCameraButton()
        configureNameStack()
        configureSelectAnOptionLabel()
        configureTableView()
        configureButton()
    }
    
    @objc func saveButtonPressed() {
    }
    
    func configureTableView() {
        profileTable.register(ProfileTableCell.nib(), forCellReuseIdentifier: ProfileTableCell.identifier)
        profileTable.dataSource = self
        profileTable.delegate = self
        tableHeight.constant = CGFloat(14 * 65)
        profileTable.backgroundColor = .clear
        profileTable.isScrollEnabled = false
    }
    
    func configureSelectAnOptionLabel() {
        selectLabel.textColor = .white
        selectLabel.font = UIFont(name: UIFont.sairaRegular, size: 16)
        selectLabel.textColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
    }
    
    func configureButton() {
        addOptionsButton.backgroundColor = .lightYellow
        addOptionsButton.titleLabel?.font = UIFont(name: UIFont.sairaRegular, size: 16)
        addOptionsButton.layer.cornerRadius = 25
        addOptionsButton.titleLabel?.textColor = .black
        
        buttonView.backgroundColor = .black
    }
    
    func configureNameStack() {
        nameTitle.text = profileViewModel.nameTitleText
        nameTitle.textColor = .white
        nameTitle.font = UIFont(name: UIFont.HelveticaNeue, size: 18)
        
        nameTextField.borderStyle = .none
        nameTextField.backgroundColor = .clear
        nameTextField.textColor = .white
        nameTextField.font = UIFont(name: UIFont.HelveticaNeue, size: 18)
        nameTextField.textAlignment = .left
        nameTextField.attributedPlaceholder = NSAttributedString(string: profileViewModel.nameTextFieldPlaceholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)])
        
        textFieldUnderline.backgroundColor = .white
    }
    
    func configureCameraButton() {
        cameraButton.layer.cornerRadius = 8
        cameraButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
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
        return 14
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = profileTable.dequeueReusableCell(withIdentifier: ProfileTableCell.identifier, for: indexPath) as? ProfileTableCell else { return UITableViewCell() }
        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        profileTable.deselectRow(at: indexPath, animated: true)
    }
}
