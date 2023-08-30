//
//  TodoList.swift
//  TodoList_TripleDB
//
//  Created by Okrie on 2023/08/27.
//

import Foundation

class TodoList_MySQL{
    var seq: Int
    var userid: String
    var title: String
    var content: String
    var insertdate: String
    var isshare: String
    var imagename: String
    var invalidate: String
    
    init(seq: Int, userid: String, title: String, content: String, insertdate: String, isshare: String, imagename: String, invalidate: String) {
        self.seq = seq
        self.userid = userid
        self.title = title
        self.content = content
        self.insertdate = insertdate
        self.isshare = isshare
        self.imagename = imagename
        self.invalidate = invalidate
    }
}
