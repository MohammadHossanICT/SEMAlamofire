//
//  ViewController.swift
//  Alomafire-Project
//
//  Created by M A Hossan on 31/01/2023.
//

import UIKit
import Combine

class ViewController: UIViewController {

    private let viewModel = ViewModel()
    private var subscribers = Set<AnyCancellable>()

    private lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.dataSource = self
        tableview.delegate = self
        tableview.prefetchDataSource = self
        tableview.showsVerticalScrollIndicator = false
        tableview.register(SchoolCell.self, forCellReuseIdentifier: SchoolCell.identifier)
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setUpUI()
        setUpBinding()
    }

    private func setUpUI() {
        view.backgroundColor = .white

        view.addSubview(tableView)

        // create constraints
        let safeArea = view.safeAreaLayoutGuide
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }

    // calling the view with combine

    private func setUpBinding() {
        viewModel
            .$school
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscribers)

        viewModel.getSchools()
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // Modving to details view controller .
        let detail = DetailViewController()
        detail.schoolNameLabel.text = "School Name: \(viewModel.getSchoolName(by: indexPath.row))"
        detail.schoolLocationLabel.text = "School Location: \(viewModel.getSchoolLocation(by: indexPath.row))"
        navigationController?.pushViewController(detail, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.school.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: SchoolCell.identifier, for: indexPath) as? SchoolCell
        else { return UITableViewCell() }

        let row = indexPath.row
        let schoolName = viewModel.getSchoolName(by: row)
        let schoolLocation = viewModel.getSchoolLocation(by: indexPath.row)

        cell.configureCell(schoolName: schoolName, schoolLocation: schoolLocation)
        return cell

    }
}

extension ViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        viewModel.loadMoreSchools()
    }

}


