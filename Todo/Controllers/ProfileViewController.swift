//
//  ProfileViewController.swift
//  Todo
//
//  Created by Arthit Thongpan on 20/3/2564 BE.
//

import UIKit
import SDCAlertView
import JGProgressHUD

class ProfileViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var service = Service()
    lazy var hud = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        let user = AuthorizationManager.shared.user!
        nameLabel.text = user.name
        emailLabel.text = user.email
    }
   
    // MARK: - Loading
    
    func showLoading() {
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
    }
    
    func showError(error: String) {
        AlertController.alert(message: error, actionTitle: "ตกลง")
    }
    
    func hideLoading() {
        hud.dismiss()
    }
    
    func close() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Service
    
    func logout() {
        showLoading()
        service.logout { [weak self] result in
            self?.hideLoading()
            switch result {
            case .success:
                AuthorizationManager.shared.token = nil
                self?.close()
            case .failure(let error):
                self?.showError(error: error.localizedDescription)
            }
        }
    }
    
    // MARK: Actions

    @IBAction func logoutButtonTapped(_ sender: Any) {
        let alert = AlertController(title: nil, message: "ยืนยันออกจากระบบ", preferredStyle: .alert)
        alert.addAction(AlertAction(title: "ยกเลิก", style: .normal))
        alert.addAction(AlertAction(title: "ออกจากระบบ", style: .preferred, handler: { [weak self] action in
            self?.logout()
        }))
        
        alert.present()
    }
}
