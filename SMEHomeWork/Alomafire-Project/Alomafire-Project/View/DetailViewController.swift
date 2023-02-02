//
//  DetailViewController.swift
//  Alomafire-Project
//
//  Created by M A Hossan on 31/01/2023.
//

import UIKit

class DetailViewController: UIViewController {

    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    public lazy var schoolNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()


    public lazy var schoolLocationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
       // stackView.frame = CGRect(x: 0, y: 15, width: self.view.frame.size.width, height: self.view.frame.size.height)
        view.addSubview(stackView)


        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
           stackView.widthAnchor.constraint(equalToConstant: 350),
            stackView.heightAnchor.constraint(equalToConstant: 100),
         ])
        stackView.addArrangedSubview(schoolNameLabel)
        stackView.addArrangedSubview(schoolLocationLabel)
        
    }

}
