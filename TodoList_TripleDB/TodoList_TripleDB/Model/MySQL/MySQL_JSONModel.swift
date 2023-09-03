//
//  JSONModel.swift
//  TodoList_TripleDB
//
//  Mysql Json 형식으로 변환한 Model
//
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
    var isfinished: String
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
