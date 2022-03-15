//
//  HomeViewController.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 19.02.2022.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var homeBackgroundImage: UIImageView!
    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var homeImageOpacity: UIView!
    
    var coordinator: MainCoordinator?
    var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
        configureBackgroundImages()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator?.navigationController.setNavigationBarHidden(true, animated: animated)
        if let name = homeViewModel.profile?.name {
            nameLabel.text = name
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator?.navigationController.setNavigationBarHidden(false, animated: animated)
    }
    
    func configureTableView() {
        menuTable.register(MenuTableCell.nib(), forCellReuseIdentifier: MenuTableCell.identifier)
        menuTable.delegate = self
        menuTable.dataSource = self
        menuTable.backgroundColor = .clear
        menuTable.isScrollEnabled = false
    }
    
    func configureLabels() {
        sexLabel.text = homeViewModel.profile?.sex?.capitalized
        sexLabel.font = UIFont(name: UIFont.sairaRegular, size: 24)
        sexLabel.textAlignment = .center
        sexLabel.textColor = .white
        
        nameLabel.isHidden = ((homeViewModel.profile?.name?.isEmpty) == nil)
        nameLabel.textColor = .lightYellow
        
        profileImageView.isHidden = true
        profileImageView.layer.cornerRadius = 8
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.lightYellow.cgColor
    }
    
    func configureBackgroundImages() {
        if sexLabel.text == "Superman" {
            homeBackgroundImage.image = UIImage(named: homeViewModel.supermanBackgroundImageName)
        } else {
            homeBackgroundImage.image = UIImage(named: homeViewModel.supergirlBackgroundImageName)
        }
        
        homeBackgroundImage.contentMode = .scaleToFill
        homeBackgroundImage.addBlackGradientLayerInForeground(
            frame: homeBackgroundImage.bounds,
            colors: [.black.withAlphaComponent(1), .black.withAlphaComponent(0.8), .black.withAlphaComponent(0.0)],
            startPoint: .init(x: 0.5, y: 1.0),
            endPoint: .init(x: 0.5, y: 0.0)
        )
        homeImageOpacity.backgroundColor = .black.withAlphaComponent(0.6)
    }
}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.mainItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = menuTable.dequeueReusableCell(withIdentifier: MenuTableCell.identifier , for: indexPath) as? MenuTableCell else { return UITableViewCell() }
        cell.configure(with: homeViewModel.mainItems[indexPath.row])
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        homeViewModel.pushToViewController(at: indexPath, coordinator: coordinator)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 57
    }
}

