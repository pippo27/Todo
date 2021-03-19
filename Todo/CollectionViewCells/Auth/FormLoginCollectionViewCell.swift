//
//  FormLoginCollectionViewCell.swift
//  Todo
//
//  Created by Arthit Thongpan on 19/3/2564 BE.
//

import UIKit
import SDCAlertView

protocol FormLoginCollectionViewCellDelegate: class {
    func formLoginCollectionViewCell(_ formLoginCollectionViewCell: FormLoginCollectionViewCell, email: String, password: String)
}

class FormLoginCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    weak var delegate: FormLoginCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        emailTextField.text = "arthit.tp@icloud.com"
        passwordTextField.text = "12345678"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        delegate = nil
    }
    
    func showErrr(message: String) {
        AlertController.alert(message: message, actionTitle: "ตกลง")
    }
    
    func validateAll() -> Bool {
        
        guard let email = emailTextField.text, email.isEmail else {
            showErrr(message: "กรุณาใส่อีเมล์ให้ถูกต้อง")
            return false
        }
        
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showErrr(message: "กรุณาใส่รหัสผ่านของท่าน")
            return false
        }
        
        return true
    }
    
    func login() {
        guard validateAll() else {
            return
        }
        
        delegate?.formLoginCollectionViewCell(self, email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    // MARK: - Actions
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        login()
    }
}

