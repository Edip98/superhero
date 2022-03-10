//
//  HomeViewController.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 19.02.2022.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var homeBackgroundImage: UIImageView!
    @IBOutlet weak var menuTable: UITableView!
    
    var coordinator: MainCoordinator?
    
    var homeViewModel = HomeViewModel()
    
    var profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSexLabel()
        configureBackgroundImages()
        menuTable.register(MenuTableCell.nib(), forCellReuseIdentifier: MenuTableCell.identifier)
        menuTable.delegate = self
        menuTable.dataSource = self
        menuTable.backgroundColor = .clear
        menuTable.isScrollEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func configureSexLabel() {
        sexLabel.text = homeViewModel.profile?.sex?.capitalized
        sexLabel.font = UIFont(name: "Saira-Regular", size: 24)
        sexLabel.textAlignment = .center
        sexLabel.textColor = .white
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 57
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        homeViewModel.pushToViewController(at: indexPath, coordinator: coordinator)
        }
    }

