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
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "TodoDetail":
            let todoDetailVC = segue.destination as! TodoDetailTableViewController
            todoDetailVC.task = sender as! Task
        default:
            break
        }
    }
    
    func registerCell() {
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
    }
    
    //MARK: - Unwind Segue Methods
    
    @IBAction func cancelAddTaskToTodoListViewController(_ segue: UIStoryboardSegue) {
    }
    
    @IBAction func addTaskToTodoListViewController(_ segue: UIStoryboardSegue) {
        if let controller = segue.source as? AddTodoTableViewController, let task = controller.task {
            // Fetch ข้อมูลใหม่ จริงๆ จะรอ response มาแล้วเอา data ไปเพิ่มใน array ก็ได้ จะได้ไม่ต้อง fetch ข้อมูลใหม่
            fetchTasks()
        }
    }
    
    @IBAction func updateTaskToTodoListViewController(_ segue: UIStoryboardSegue) {
        if let controller = segue.source as? TodoDetailTableViewController, let task = controller.task {
            updateTodo(task)
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
    
    func updateTodo(_ task: Task) {
        let index = tasks.firstIndex { $0.id == task.id }!
        showLoading()
        service.updateTask(id: task.id!, description: task.description ?? "", completed: task.completed ?? false) { [weak self] result in
            self?.hideLoading()
            switch result {
            case .success:
                self?.tasks[index] = task
                let indexPath = IndexPath(row: index, section: 0)
                self?.tableView.reloadRows(at: [indexPath], with: .automatic)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "TodoDetail", sender: tasks[indexPath.row])
    }
}


