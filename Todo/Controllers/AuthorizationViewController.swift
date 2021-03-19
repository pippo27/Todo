//
//  AuthorizationViewController.swift
//  Todo
//
//  Created by Arthit Thongpan on 19/3/2564 BE.
//

import UIKit
import JGProgressHUD
import SDCAlertView

class AuthorizationViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var service = Service()
    lazy var hud = JGProgressHUD()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    func login(email: String, password: String) {
        showLoading()
        service.login(email: email, password: password) { [weak self] result in
            self?.hideLoading()
            switch result {
            case .success(let authData):
                AuthorizationManager.shared.token = authData!.token
                AuthorizationManager.shared.user = authData!.user
                self?.close()
            case .failure(let error):
                self?.showError(error: error.localizedDescription)
            }
        }
    }
    
    func register(name: String, age: String, email: String, password: String) {
        showLoading()
        service.register(name: name, age: age, email: email, password: password) { [weak self] result in
            self?.hideLoading()
            switch result {
            case .success(let authData):
                AuthorizationManager.shared.token = authData!.token
                AuthorizationManager.shared.user = authData!.user
                self?.close()
            case .failure(let error):
                self?.showError(error: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Setup Cells

    func cellForForm(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorizationFormCell", for: indexPath) as! AuthorizationTableViewCell
        cell.delegate = self
        cell.collectionView.collectionViewLayout.invalidateLayout()
        return cell
    }
}


// MARK: - AuthorizationFormTableViewCellDelegate

extension AuthorizationViewController: AuthorizationFormTableViewCellDelegate {
    func authorizationFormTableViewCell(_ authorizationFormTableViewCell: AuthorizationTableViewCell, registerWithName name: String, age: String, email: String, password: String) {
        register(name: name, age: age, email: email, password: password)
    }
    
    func authorizationFormTableViewCell(_ authorizationFormTableViewCell: AuthorizationTableViewCell, loginWithEmail email: String, password: String) {
        login(email: email, password: password)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension AuthorizationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForForm(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450.0
    }
}


