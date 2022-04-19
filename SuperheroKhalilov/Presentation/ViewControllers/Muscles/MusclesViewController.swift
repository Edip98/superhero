//
//  MusclesViewController.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 22.02.2022.
//

import UIKit

enum MusclesViewControllerMode {
    case normal, edit
}

class MusclesViewController: BaseViewController {
    
    @IBOutlet weak var musclesTable: UITableView!
    
    var mode: MusclesViewControllerMode = .normal
    var coordinator: MainCoordinator?
    private let musclesViewModel = MuscleViewModel()
    let musclesSectionHeader = MusclesSectionHeader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar()
        configureTableView()
    }
    
    private func configureNavBar() {
        guard mode == .edit else { return }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: musclesViewModel.rightBarButtonItemTitle, style: .plain, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc func saveButtonPressed() {
        
    }
    
    private func configureTableView() {
        musclesTable.register(ExerciseCell.nib(), forCellReuseIdentifier: ExerciseCell.identifier)
        musclesTable.register(UINib(nibName: MusclesSectionHeader.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: MusclesSectionHeader.identifier)
        musclesTable.delegate = self
        musclesTable.dataSource = self
        musclesTable.backgroundColor = .clear
    }
}

extension MusclesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return musclesViewModel.singleMuscleViewModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let muscleSection = musclesViewModel.singleMuscleViewModel[section]
        
        return muscleSection.isOpened ? muscleSection.exercises.count : 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let musclesSectionHeader = musclesTable.dequeueReusableHeaderFooterView(withIdentifier: MusclesSectionHeader.identifier) as! MusclesSectionHeader
        
        musclesSectionHeader.configure(with: musclesViewModel.singleMuscleViewModel[section])
        
        musclesSectionHeader.headerTappedHandler = { [weak self] in
            guard let self = self else { return }
            
            var indexPaths = [IndexPath]()
            
            for row in 0..<self.musclesViewModel.singleMuscleViewModel[section].exercises.count {
                indexPaths.append(IndexPath(row: row, section: section))
            }
            
            self.musclesViewModel.singleMuscleViewModel[section].isOpened.toggle()
            self.musclesTable.reloadData()
        }
        return musclesSectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 183
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = musclesTable.dequeueReusableCell(withIdentifier: ExerciseCell.identifier, for: indexPath) as? ExerciseCell else { return UITableViewCell() }
        cell.configure(with: musclesViewModel.singleMuscleViewModel[indexPath.section].exercises[indexPath.row], for: mode)
        cell.coordinator = coordinator
        cell.delegate = self
        return cell
    }
}

extension MusclesViewController: MusclesTableCellDelegate {
    func update() {
        self.musclesTable.reloadData()
    }
}
