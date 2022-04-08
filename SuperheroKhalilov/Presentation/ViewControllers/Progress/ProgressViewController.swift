//
//  ProgressViewController.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 22.02.2022.
//

import UIKit

class ProgressViewController: BaseViewController {
    
    @IBOutlet weak var progressTableView: UITableView!
    
    var coordinator: MainCoordinator?
    private let progressViewModel = ProgressViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        progressTableView.register(ProgressTableCell.nib(), forCellReuseIdentifier: ProgressTableCell.identifier)
        progressTableView.delegate = self
        progressTableView.dataSource = self
        progressTableView.backgroundColor = .clear
        progressTableView.isScrollEnabled = false
    }
}

extension ProgressViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if progressViewModel.profile?.parameters?.count == 0 {
            progressViewModel.presentProgressAlertView(view: self.view)
        }
        return progressViewModel.bodyParameterViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = progressTableView.dequeueReusableCell(withIdentifier: ProgressTableCell.identifier, for: indexPath) as? ProgressTableCell else { return UITableViewCell() }
        cell.configure(with: progressViewModel.bodyParameterViewModel[indexPath.row])
        return cell
    }
}

extension ProgressViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let title = progressViewModel.bodyParameterViewModel[indexPath.row].bodyPart else { return }
        guard let date = progressViewModel.bodyParameterViewModel[indexPath.row].dateArray.first else { return }
        let array = [progressViewModel.bodyParameterViewModel[indexPath.row]]
        coordinator?.presentProgressChartVC(title: title + " " + progressViewModel.chart, bodyName: title + ",", date: date, viewModel: array)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 57
    }
}
