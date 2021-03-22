//
//  AddTodoTableViewController.swift
//  Todo
//
//  Created by Arthit Thongpan on 20/3/2564 BE.
//

import UIKit
import SDCAlertView
import JGProgressHUD

class AddTodoTableViewController: UITableViewController {

    @IBOutlet var textView: UITextView!
    lazy var hud = JGProgressHUD()
    var service = Service()
    
    var task: Task?
    
    override func viewDidLoad() {
      super.viewDidLoad()
        textView.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        textView.resignFirstResponder()
    }
    
    @IBAction func saveButtonItemTapped(_ sender: Any) {
        addTask()
    }
    
    // MARK: - Validation
    
    func validate() -> Bool {
        guard let text =  textView.text, !text.isEmpty else {
            showError(error: "กรุณาใส่ข้อมูลก่อนนะจ๊ะ")
            return false
        }
        
        return true
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
        performSegue(withIdentifier: "GoToTodoList", sender: nil)
    }
    
    // MARK: - Service
    
    func addTask() {
        guard validate() else {
            return
        }
        
        showLoading()
        service.createTask(description: textView.text!) { [weak self] result in
            self?.hideLoading()
            switch result {
            case .success(let task):
                self?.task = task
                self?.close()
            case .failure(let error):
                self?.showError(error: error.localizedDescription)
            }
        }
    }
}
