//
//  TaskResponse.swift
//  Todo
//
//  Created by Arthit Thongpan on 19/3/2564 BE.
//

import Foundation

struct Task: Decodable {
    let id: String?
    var description: String?
    var completed: Bool?
    let owner: String?
    private let createdAt: String?
    private let updatedAt: String?
    
    var createDate: String? {
        guard let dateString = createdAt else { return nil }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = formatter.date(from: dateString) else { return nil}
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: date)
    }
    
    var createTime: String? {
        guard let dateString = createdAt else { return nil }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = formatter.date(from: dateString) else { return nil}
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
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

struct UpdateTaskResponse: Decodable {
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
