//
//  BodyParameterView.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 16.03.2022.
//

import UIKit

protocol BodyParameterViewControllerDelegate: AnyObject{
    func didTapOnCancelButton()
    func didTapOnSelectButton()
}

class BodyParameterViewController: UIViewController, Storyboarded {
    
    @IBOutlet var bodyParameterView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var selectOptionLabel: UILabel!
    @IBOutlet weak var parametersTableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var selectButton: UIButton!
    
    var viewModel = ProfileViewModel()
    weak var delegate: BodyParameterViewControllerDelegate?

    override func viewDidLoad() {
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parametersTableView.reloadData()
    }
    
    func configureUI() {
        bodyParameterView.backgroundColor = .black.withAlphaComponent(0.65)
        
        contentView.backgroundColor = .black
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8
        contentView.layer.borderColor = UIColor.white.cgColor
        
        parametersTableView.register(BodyParameterCell.nib(), forCellReuseIdentifier: BodyParameterCell.identifier)
        parametersTableView.dataSource = self
        parametersTableView.delegate = self
        parametersTableView.backgroundColor = .black
        
        selectOptionLabel.textColor = .customYellow
        selectOptionLabel.font = .font(name: .SairaRegular, size: 18)
        
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.titleLabel?.font = .font(name: .SairaRegular, size: 18)
        
        selectButton.titleLabel?.font = .font(name: .SairaRegular, size: 18)
        selectButton.setTitleColor(.customYellow, for: .normal)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        delegate?.didTapOnCancelButton()
    }
    
    @IBAction func selecetButtonPressed(_ sender: UIButton) {
        delegate?.didTapOnSelectButton()
    }
}

extension BodyParameterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bodyParameteresViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = parametersTableView.dequeueReusableCell(withIdentifier: BodyParameterCell.identifier, for: indexPath) as? BodyParameterCell else { return UITableViewCell() }
        cell.configure(with: viewModel.bodyParameteresViewModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 38
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.toggleIsSelected(at: indexPath.row)
        parametersTableView.reloadRows(at: [indexPath], with: .none)
    }
}
