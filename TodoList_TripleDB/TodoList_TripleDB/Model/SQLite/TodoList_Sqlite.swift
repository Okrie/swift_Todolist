//
//  TodoList.swift
//  TodoList_TripleDB
//
//  SQLite3 Todolist Model
//
//
//  Created by Okrie on 2023/08/26.
//

import Foundation

class TodoList_SQLite{
    var seq: String
    var userid: String
    var title: String
    var content: String
    var insertdate: String
    var isshare: String
    var imagename: String
    var image: Data
    var invalidate: String
    var isfinished: String
    
    init(seq: String, userid: String, title: String, content: String, insertdate: String, isshare: String, imagename: String, image: Data, invalidate: String, isfinished: String) {
        self.seq = seq
        self.userid = userid
        self.title = title
        self.content = content
        self.insertdate = insertdate
        self.isshare = isshare
        self.imagename = imagename
        self.image = image
        self.invalidate = invalidate
        self.isfinished = isfinished
    }
}
