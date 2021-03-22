//
//  Service.swift
//  Todo
//
//  Created by Arthit Thongpan on 19/3/2564 BE.
//

import Alamofire
import Foundation

class Service {
    private static let END_POINT = "https://api-nodejs-todolist.herokuapp.com"
    private static let REGISTER_API = "\(END_POINT)/user/register"
    private static let LOGIN_API = "\(END_POINT)/user/login"
    private static let LOGOUT_API = "\(END_POINT)/user/logout"
    private static let ALL_TASK_API = "\(END_POINT)/task"
    private static let GET_TASK_API = "\(END_POINT)/task/%@"
    private static let CREATE_TASK_API = "\(END_POINT)/task"
    private static let UPDATE_TASK_API = "\(END_POINT)/task/%@"
    private static let DELETE_TASK_API = "\(END_POINT)/task/%@"
    
    let httpClient: HttpClient
    init(client: HttpClient = HttpClient()) {
        self.httpClient = client
    }
    
    // MARK: Auth
    
    func register(name: String, age: String, email: String, password: String, completion: @escaping(ApiResult<AuthData>) -> ()) {
        let parameters: Parameters = [
            "name": name,
            "age": age,
            "email": email,
            "password": password,
        ]
        
        httpClient.request(Service.REGISTER_API, method: .post, parameters: parameters) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(AuthData.self, from: data! as! Data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping(ApiResult<AuthData>) -> ()) {
        let parameters: Parameters = [
            "email": email,
            "password": password,
        ]
        
        httpClient.request(Service.LOGIN_API, method: .post, parameters: parameters) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(AuthData.self, from: data! as! Data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func logout(completion: @escaping(ApiResult<Any>) -> ()) {
        httpClient.request(Service.LOGOUT_API, method: .post) { result in
            switch result {
            case .success:
                completion(.success(nil))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Task
    
    func createTask(description: String, completion: @escaping(ApiResult<Task>) -> ()) {
        let parameters: Parameters = [
            "description": description
        ]
        
        httpClient.request(Service.CREATE_TASK_API, method: .post, parameters: parameters) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(CreateTaskResponse.self, from: data! as! Data)
                    completion(.success(response.task))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getTask(id: String, completion: @escaping(ApiResult<Task>) -> ()) {
        let url = String(format: Service.GET_TASK_API, arguments: [id])
        httpClient.request(url, method: .get) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(TaskResponse.self, from: data! as! Data)
                    completion(.success(response.task))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAllTask(_ completion: @escaping(ApiResult<[Task]>) -> ()) {
        httpClient.request(Service.ALL_TASK_API, method: .get) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(AllTaskResponse.self, from: data! as! Data)
                    completion(.success(response.tasks))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateTask(description: String, completed: Bool = false, completion: @escaping(ApiResult<Task>) -> ()) {
        let parameters: Parameters = [
            "description": description,
            "completed": completed,
        ]
        
        httpClient.request(Service.UPDATE_TASK_API, method: .put, parameters: parameters) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(TaskResponse.self, from: data! as! Data)
                    completion(.success(response.task))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteTask(id: String, completion: @escaping(ApiResult<Task>) -> ()) {
        let url = String(format: Service.DELETE_TASK_API, arguments: [id])
        httpClient.request(url, method: .delete) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(TaskResponse.self, from: data! as! Data)
                    completion(.success(response.task))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
