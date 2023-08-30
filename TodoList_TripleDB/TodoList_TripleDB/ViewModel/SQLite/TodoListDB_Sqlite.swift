//
//  TodoListDB.swift
//  TodoList_TripleDB
//
//  Created by Okrie on 2023/08/26.
//

import Foundation
import SQLite3

protocol QueryModelProtocol{
    func downloadItem(items: [TodoList_SQLite])
}

class TodoListDB{
    var db: OpaquePointer?
    var todoList: [TodoList_SQLite] = []
    var delegate: QueryModelProtocol!
    
    init(){
        
        // SQLite 설정하기
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appending(path: "TodoList.sqlite")
        if sqlite3_open(fileURL.path(percentEncoded: true), &db) != SQLITE_OK{
            print("Error opening database")
        }
        
        // create table
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS todolist (tid TEXT PRIMARY KEY AUTOINCREMENT, ttitle TEXT, tcontent TEXT, tinsertdate TEXT, tinvalidate TEXT)", nil, nil, nil) != SQLITE_OK{
            let errMSG = String(cString: sqlite3_errmsg(db))
            print("Error creating table: \(errMSG)")
            return
        }
    }
    
    func selectAllDB(){
        var stmt: OpaquePointer?
        var locations: [TodoList_SQLite] = []
        
        let queryString = "SELECT * FROM todolist"
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        
        while (sqlite3_step(stmt) == SQLITE_ROW){
            let id = String(cString: sqlite3_column_text(stmt, 0))
            let title = String(cString: sqlite3_column_text(stmt, 1))
            let content = String(cString: sqlite3_column_text(stmt, 2))
            let insertdate = String(cString: sqlite3_column_text(stmt, 3))
            let invalidate = String(cString: sqlite3_column_text(stmt, 4))
            
            locations.append(TodoList_SQLite(userid: id, title: title, content: content, insertdate: insertdate, invalidate: invalidate))
        }
        
        DispatchQueue.main.async {
            self.delegate.downloadItem(items: locations)
        }
    }
    
    func deleteDB(_ id: String, title:String) -> (Bool){
        var stmt: OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "DELETE FROM todolist WHERE tid = ? AND ttitle = ?"
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        sqlite3_bind_text(stmt, 1, id, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 2, title, -1, SQLITE_TRANSIENT)
        //        sqlite3_step(stmt)
        
        if sqlite3_step(stmt) == SQLITE_DONE{
            return true
        }else{
            return false
        }
    }
    
    func insertDB(_ id: String, title: String, content: String, invalidate: String) -> (Bool){
        var stmt: OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "INSERT INTO todolist (tid, ttitle, tcontent, tinsertdate, tinvalidate) VALUES (?, ?, ?, ?, ?)"
        
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        sqlite3_bind_text(stmt, 1, id, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 2, title, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 3, content, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 4, "202308270910", -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 5, invalidate, -1, SQLITE_TRANSIENT)
                          
        if sqlite3_step(stmt) == SQLITE_DONE{
            return true
        }else{
            return false
        }
    }
    
    func updateDB(_ id: String, title: String, content: String, invalidate: String) -> Bool{
        var stmt: OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "UPDATE SET ttitle = ?, tcontent = ?, tinvalidate = ? WHERE tid = ?"
        
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        sqlite3_bind_text(stmt, 1, title, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 2, content, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 3, invalidate, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 4, id, -1, SQLITE_TRANSIENT)
        
        if sqlite3_step(stmt) == SQLITE_DONE{
            return true
        }else{
            return false
        }
    }
    
}
