//
//  LandingViewController.swift
//  Todo
//
//  Created by Arthit Thongpan on 19/3/2564 BE.
//

import UIKit

class LandingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let _ = AuthorizationManager.shared.token else {
            performSegue(withIdentifier: "Auth", sender: nil)
            return
        }
        
        performSegue(withIdentifier: "Main", sender: nil)
    }
}
