//
//  JSONModel.swift
//  TodoList_TripleDB
//
//  Created by Okrie on 2023/08/28.
//

import Foundation

struct TodoListJSON: Codable{
    var seq: Int
    var userid: String
    var title: String
    var content: String
    var insertdate: String
    var isshare: String
    var imagename: String
    var invalidate: String
}

struct TodoListResults: Codable{
    let results: [TodoListJSON]
}

struct UserDataJSON: Codable{
    var userid: String
    var userpw: String
    var insertdate: String
    var invalidate: String
    var isshare: String
}

struct LoginUserJSON: Codable{
    var count: Int
}

struct DupliUserJSON: Codable{
    var count: Int
}

struct ShareUserJSON: Codable{
    var userid: String
//    var invalidate: String
//    var isshare: String
}

struct ShareUserResult: Codable{
    let results: [ShareUserJSON]
}
