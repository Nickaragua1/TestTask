//
//  shortViewController.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 13.06.2024.
//

import UIKit

final class ShortViewController: UIViewController {
    
    //MARK: Private properties
    private let errorView = ErrorView()
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
    }
    
    //MARK: Private methods
    private func setupLayouts() {
        view.addSubview(errorView)
        
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
