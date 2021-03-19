//
//  FormRegisterCollectionViewCell.swift
//  Todo
//
//  Created by Arthit Thongpan on 19/3/2564 BE.
//

import UIKit
import SDCAlertView

protocol FormRegisterCollectionViewCellDelegate: class {
    func formRegisterCollectionViewCell(_ formRegisterCollectionViewCell: FormRegisterCollectionViewCell, name: String, age: String, email: String, password: String)
}

class FormRegisterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    weak var delegate: FormRegisterCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        delegate = nil
    }
    
    func showErrr(message: String) {
        AlertController.alert(message: message, actionTitle: "ตกลง")
    }
    
    func validateAll() -> Bool {
        guard let name = nameTextField.text, !name.isEmpty else {
            showErrr(message: "กรุณาใส่ชื่อของท่าน")
            return false
        }
        
        guard let age = ageTextField.text, age.isNumeric else {
            showErrr(message: "กรุณาใส่อายุของเป็นตัวเลขเท่านั้น")
            return false
        }
        
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
 
    func register() {
        guard validateAll() else {
            return
        }
        
        delegate?.formRegisterCollectionViewCell(self, name: nameTextField.text!, age: ageTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
    }

    // MARK: - Actions
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        register()
    }
}
