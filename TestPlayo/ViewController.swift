//
//  ViewController.swift
//  TestPlayo
//
//  Created by Sushmitha Bhat on 15/11/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureMainController()
        
    }
    func configureMainController() {
        let MainVC = MainViewController()
        let navVC = UINavigationController(rootViewController: MainVC)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true, completion: nil)
    }


}

