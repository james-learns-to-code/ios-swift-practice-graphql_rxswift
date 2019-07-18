//
//  ViewController.swift
//  BaseProject
//
//  Created by leedongseok on 12/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: Action
    
    @IBAction private func didTapFirstButton() {
        presentVC()
    }
    @IBAction private func didTapSecondButton() {
        presentVCWithView()
    }
    @IBAction private func didTapThirdButton() {
        presentVCWithXib()
    }
    
    // MARK: Present
    
    private func presentVC() {
        let vc = StarwarsViewController()
        present(vc, animated: true, completion: nil)
    }
    
    private func presentVCWithView() {
        let vc = StarwarsViewControllerWithView()
        present(vc, animated: true, completion: nil)
    }
    
    private func presentVCWithXib() {
        let vc = StarwarsViewControllerWithXib(nibName: "StarwarsViewControllerWithXib", bundle: nil)
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchUserList()
    }
    
    // MARK: API
    func fetchUserList() {
        let name = "james"
        GitHubNetworkManager.shared.requestUserListByName(name) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
