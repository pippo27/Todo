//
//  TodoListViewController.swift
//  Todo
//
//  Created by Arthit Thongpan on 20/3/2564 BE.
//

import UIKit
import SDCAlertView
import JGProgressHUD

class TodoListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    lazy var hud = JGProgressHUD()
    
    var service = Service()
    var tasks: [Task] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        fetchTasks()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func registerCell() {
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
    }
    
    //MARK: - Unwind Segue Methods
    
    @IBAction func cancelToDiaryViewController(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func addTaskToTodoListViewController(_ segue: UIStoryboardSegue) {
        if let controller = segue.source as? AddTodoTableViewController, let task = controller.task {
//            tasks.append(task)
//            tableView.reloadData()
            
            // Fetch ข้อมูลใหม่
            fetchTasks()
        }
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
    
    // MARK: Service
    
    func fetchTasks() {
        showLoading()
        service.getAllTask { [weak self] result in
            self?.hideLoading()
            switch result {
            case .success(let tasks):
                self?.tasks = tasks ?? []
                self?.tableView.reloadData()
            case .failure(let error):
                self?.showError(error: error.localizedDescription)
            }
        }
    }
    
    func deleteTodo(at indexPath: IndexPath) {
        showLoading()
        let task = tasks[indexPath.row]
        service.deleteTask(id: task.id!) { [weak self] result in
            self?.hideLoading()
            switch result {
            case .success:
                self?.tasks.remove(at: indexPath.row)
                self?.tableView.deleteRows(at: [indexPath], with: .fade)
            case .failure(let error):
                self?.showError(error: error.localizedDescription)
            }
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        cell.task = tasks[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTodo(at: indexPath)
        }
    }
}


