//
//  AuthorizationTableViewCell.swift
//  Todo
//
//  Created by Arthit Thongpan on 19/3/2564 BE.
//

import UIKit

protocol AuthorizationFormTableViewCellDelegate: class {
    func authorizationFormTableViewCell(_ authorizationFormTableViewCell: AuthorizationTableViewCell, loginWithEmail email: String, password: String)
    func authorizationFormTableViewCell(_ authorizationFormTableViewCell: AuthorizationTableViewCell, registerWithName name: String, age: String, email: String, password: String)
}

enum AuthTab {
    case login
    case register
}

class AuthorizationTableViewCell: UITableViewCell {
    @IBOutlet weak var loginButtonView: AuthorizationButtonView!
    @IBOutlet weak var registerButtonView: AuthorizationButtonView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: AuthorizationFormTableViewCellDelegate?
    
    var tab: AuthTab = .login {
        didSet {
            if tab == .login {
                tabLogin()
            } else {
                tabRegister()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        configTabAction()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func registerCell() {
        collectionView.register(UINib(nibName: "FormLoginCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FormLoginCell")
        collectionView.register(UINib(nibName: "FormRegisterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FormRegisterCell")
    }
    
    func configTabAction() {
        tab = .login
        
        loginButtonView.tappClosure = { [weak self] in
            self?.tab = .login
        }
        
        registerButtonView.tappClosure = { [weak self] in
            self?.tab = .register
        }
    }
    
    // MARK: - Tab Actions
    
    func tabLogin() {
        loginButtonView.indicatorView.isHidden = false
        registerButtonView.indicatorView.isHidden = true
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func tabRegister() {
        loginButtonView.indicatorView.isHidden = true
        registerButtonView.indicatorView.isHidden = false
        collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: true)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension AuthorizationTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item ==  0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FormLoginCell", for: indexPath) as! FormLoginCollectionViewCell
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FormRegisterCell", for: indexPath) as! FormRegisterCollectionViewCell
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
//            return CGSize.zero
//        }
        
        let size = CGSize(width: collectionView.frame.width, height: 450.0)
        return size
    }
}

// MARK: FormLoginCollectionViewCellDelegate

extension AuthorizationTableViewCell: FormLoginCollectionViewCellDelegate {
    func formLoginCollectionViewCell(_ formLoginCollectionViewCell: FormLoginCollectionViewCell, email: String, password: String) {
        delegate?.authorizationFormTableViewCell(self, loginWithEmail: email, password: password)
    }
}

// MARK: FormRegisterCollectionViewCellDelegate

extension AuthorizationTableViewCell: FormRegisterCollectionViewCellDelegate {
    func formRegisterCollectionViewCell(_ formRegisterCollectionViewCell: FormRegisterCollectionViewCell, name: String, age: String, email: String, password: String) {
        delegate?.authorizationFormTableViewCell(self, registerWithName: name, age: age, email: email, password: password)
    }
}


// MARK: - Classes

class AuthorizationButtonView: UIView {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var indicatorView: UIView!
    
    var tappClosure: (() -> Void)?
    
    var title: String = "" {
        didSet {
            button.setTitle(title, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        tappClosure?()
    }
}
