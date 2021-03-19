//
//  User.swift
//  Todo
//
//  Created by Arthit Thongpan on 19/3/2564 BE.
//


struct User: Codable {
    let id: String
    let name: String
    let age: Int
    let email: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case age
        case email
        case createdAt
        case updatedAt
    }
}
