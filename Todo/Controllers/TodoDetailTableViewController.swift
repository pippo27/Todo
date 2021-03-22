//
//  TodoDetailTableViewController.swift
//  Todo
//
//  Created by Arthit Thongpan on 20/3/2564 BE.
//

import UIKit

class TodoDetailTableViewController: UITableViewController {
    @IBOutlet weak var buttonItem: UIBarButtonItem!
    @IBOutlet weak var datetimeCell: UITableViewCell!
    @IBOutlet weak var completedSwitch: UISwitch!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var isEdit = false
    var task: Task!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        datetimeCell.textLabel?.text = "\(task.createDate ?? "") \(task.createTime ?? "")"
        descriptionTextView.text = task.description
        completedSwitch.isOn = task.completed ?? false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        descriptionTextView.resignFirstResponder()
    }
    
    // MARK: - Actions
    
    @IBAction func buttonItemTapped(_ sender: Any) {
        isEdit = !isEdit
        buttonItem.title = isEdit ? "Save" : "Edit"
        if isEdit {
            descriptionTextView.isEditable = true
            descriptionTextView.becomeFirstResponder()
        } else {// Save
            descriptionTextView.isEditable = false
            descriptionTextView.resignFirstResponder()
            task.description = descriptionTextView.text
            performSegue(withIdentifier: "UpdateTask", sender: task)
        }
    }
    
    @IBAction func onSwitchChanged(_ sender: Any) {
        task.completed = completedSwitch.isOn
        performSegue(withIdentifier: "UpdateTask", sender: task)
    }
}
