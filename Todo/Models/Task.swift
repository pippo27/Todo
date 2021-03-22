//
//  TaskResponse.swift
//  Todo
//
//  Created by Arthit Thongpan on 19/3/2564 BE.
//

import Foundation

struct Task: Decodable {
    let id: String?
    let description: String?
    let completed: Bool?
    let owner: String?
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case description
        case completed
        case owner
        case createdAt
        case updatedAt
    }
}

struct TaskResponse: Decodable {
    let success: Bool
    let task: Task
}

struct CreateTaskResponse: Decodable {
    let success: Bool
    let task: Task
    
    enum CodingKeys: String, CodingKey {
        case success
        case task = "data"
    }
}

struct DeleteTaskResponse: Decodable {
    let success: Bool
    let task: Task
    
    enum CodingKeys: String, CodingKey {
        case success
        case task = "data"
    }
}

struct AllTaskResponse: Decodable {
    let count: Int
    let tasks: [Task]
    
    enum CodingKeys: String, CodingKey {
        case count
        case tasks = "data"
    }
}
