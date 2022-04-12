//
//  HomeViewController.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 19.02.2022.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var menuTable: UITableView!
    
    var coordinator: MainCoordinator?
    private var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
        configureTableView()
        configureCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator?.navigationController.setNavigationBarHidden(true, animated: animated)
        homeViewModel.updateViewModel()
        homeCollectionView.reloadData()
        if let name = homeViewModel.profile?.name {
            nameLabel.text = name
        }
        configureProfileImageView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator?.navigationController.setNavigationBarHidden(false, animated: animated)
    }
    
    private func configureProfileImageView() {
        if let image = ProfileManager.sharedInstance.userProfile?.image {
            if !image.isEmpty {
                profileImageView.isHidden = false
                profileImageView.image = UIImage(data: image)
                profileImageView.layer.cornerRadius = 8
                profileImageView.layer.borderWidth = 1
                profileImageView.layer.borderColor = UIColor.customYellow.cgColor
                profileImageView.contentMode = .scaleAspectFill
            } else {
                profileImageView.isHidden = true
            }
        }
    }
    
    private func configureCollection() {
        homeCollectionView.register(HomeCollectionViewCell.nib(), forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        homeCollectionView.backgroundColor = .clear
        homeCollectionView.dataSource = self
    }
    
    private func configureTableView() {
        menuTable.register(MenuTableCell.nib(), forCellReuseIdentifier: MenuTableCell.identifier)
        menuTable.delegate = self
        menuTable.dataSource = self
        menuTable.backgroundColor = .clear
        menuTable.isScrollEnabled = false
    }
    
    private func configureLabels() {
        sexLabel.text = homeViewModel.profile?.sex?.capitalized
        sexLabel.font = .font(name: .SairaRegular, size: 24)
        sexLabel.textAlignment = .center
        sexLabel.textColor = .white
        
        nameLabel.isHidden = ((homeViewModel.profile?.name?.isEmpty) == nil)
        nameLabel.textColor = .customYellow
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
        homeViewModel.pushToViewController(at: indexPath, coordinator: coordinator, viewController: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 57
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.bodyParameterViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: homeViewModel.bodyParameterViewModel[indexPath.row])
        return cell
    }
}
