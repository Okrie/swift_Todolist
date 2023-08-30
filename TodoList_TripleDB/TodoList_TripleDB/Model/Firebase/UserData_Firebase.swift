//
//  UserData_Firebase.swift
//  TodoList_TripleDB
//
//  Firebase Userdata Model
//
//
//  Created by Okrie on 2023/08/26.
//

import Foundation

class UserData_Firebase{
    var userid: String
    var userpw: String
    var insertdate: String
    var invalidate: String
    var isshare: String
    
    init(userid: String, userpw: String, insertdate: String, invalidate: String, isshare: String) {
        self.userid = userid
        self.userpw = userpw
        self.insertdate = insertdate
        self.invalidate = invalidate
        self.isshare = isshare
    }
}
