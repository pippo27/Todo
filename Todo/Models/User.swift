//
//  User.swift
//  Todo
//
//  Created by Arthit Thongpan on 19/3/2564 BE.
//


struct User: Codable {
    let id: Int
    let name: String
    let age: Int
    let email: String
    let createAt: String
    let updateAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case age
        case email
        case createAt
        case updateAt
    }
}
