//
//  TodoList.swift
//  TodoList_TripleDB
//
//  Firebase Todolist Model
//
//
//  Created by Okrie on 2023/08/26.
//

import Foundation

class TodoList_Firebase{
    var documentId: String
    var seq: String
    var userid: String
    var title: String
    var content: String
    var insertdate: String
    var isshare: String
    var imagename: String
    
    init(documentId: String, seq: String, userid: String, title: String, content: String, insertdate: String, isshare: String, imagename: String) {
        self.documentId = documentId
        self.seq = seq
        self.userid = userid
        self.title = title
        self.content = content
        self.insertdate = insertdate
        self.isshare = isshare
        self.imagename = imagename
    }
    
}

