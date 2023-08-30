//
//  TodoList.swift
//  TodoList_TripleDB
//
//  Created by Okrie on 2023/08/26.
//

import Foundation

class TodoList_SQLite{
    var userid: String
    var title: String
    var content: String
    var insertdate: String
    var invalidate: String
    
    init(userid: String, title: String, content: String, insertdate: String, invalidate: String) {
        self.userid = userid
        self.title = title
        self.content = content
        self.insertdate = insertdate
        self.invalidate = invalidate
    }
}
