//
//  TaskResponse.swift
//  Todo
//
//  Created by Arthit Thongpan on 19/3/2564 BE.
//

import Foundation

struct Task: Decodable {
    let id: Int?
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


struct AllTaskResponse: Decodable {
    let count: Int
    let tasks: [Task]
}
