//
//  TodoListDB.swift
//  TodoList_TripleDB
//
//  SQLite 사용을 위한 ViewModel
//  일정을 SQLite에 insert, select, update를 하기 위한 뷰모델
//  extension 으로 사용하기 위해 protocol로 선언하여 사용
//  delete구문이 없는 이유는 완전 삭제가 아닌 히스토리를 남기기 위해 update를 통해 invalidate 값만 변경하여 관리
//  유저는 SQLite 로 관리 하지 않음
//
//  Created by Okrie on 2023/08/26.
//

import Foundation
import SQLite3

protocol QueryModelSQLiteProtocol{
    func downloadItem(items: [TodoList_SQLite])
}

class TodoListDB_SQLITE{
    var db: OpaquePointer?
    var todoList: [TodoList_SQLite] = []
    var delegate: QueryModelSQLiteProtocol!
    
    init(){
        
        // SQLite 설정하기
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appending(path: "TodoList.sqlite")
        if sqlite3_open(fileURL.path(percentEncoded: true), &db) != SQLITE_OK{
            print("Error opening database")
        }
        
        // create table
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS todolist (seq INTEGER PRIMARY KEY AUTOINCREMENT, userid TEXT, title TEXT, content TEXT, insertdate TEXT, isshare TEXT, imagename TEXT, image BLOB, invalidate TEXT)", nil, nil, nil) != SQLITE_OK{
            let errMSG = String(cString: sqlite3_errmsg(db))
            print("Error creating table: \(errMSG)")
            return
        }
    }
    
    func selectAllDB(){
        var stmt: OpaquePointer?
        var locations: [TodoList_SQLite] = []
        var imageData: Data?
        
        let queryString = "SELECT * FROM todolist"
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        
        while (sqlite3_step(stmt) == SQLITE_ROW){
            let seq = String(cString: sqlite3_column_text(stmt, 0))
            let id = String(cString: sqlite3_column_text(stmt, 1))
            let title = String(cString: sqlite3_column_text(stmt, 2))
            let content = String(cString: sqlite3_column_text(stmt, 3))
            let insertdate = String(cString: sqlite3_column_text(stmt, 4))
            let isshare = String(cString: sqlite3_column_text(stmt, 5))
            let imagename = String(cString: sqlite3_column_text(stmt, 6))
            if let blobData = sqlite3_column_blob(stmt, 7){
                let blobLength = sqlite3_column_bytes(stmt, 7)
                let image = Data(bytes: blobData, count: Int(blobLength))
                imageData = image
            }
            let invalidate = String(cString: sqlite3_column_text(stmt, 8))
            
            locations.append(TodoList_SQLite(seq: seq, userid: id, title: title, content: content, insertdate: insertdate, isshare: isshare, imagename: imagename, image: imageData!, invalidate: invalidate))
        }
        sqlite3_finalize(stmt)
        DispatchQueue.main.async {
            self.delegate.downloadItem(items: locations)
        }
    }
    
    func selectIDDB(id: String){
        var stmt: OpaquePointer?
        var locations: [TodoList_SQLite] = []
        var imageData: Data?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "SELECT * FROM todolist WHERE userid = ?"
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        sqlite3_bind_text(stmt, 1, id, -1, SQLITE_TRANSIENT)
        
        while (sqlite3_step(stmt) == SQLITE_ROW){
            let seq = String(cString: sqlite3_column_text(stmt, 0))
            let id = String(cString: sqlite3_column_text(stmt, 1))
            let title = String(cString: sqlite3_column_text(stmt, 2))
            let content = String(cString: sqlite3_column_text(stmt, 3))
            let insertdate = String(cString: sqlite3_column_text(stmt, 4))
            let isshare = String(cString: sqlite3_column_text(stmt, 5))
            let imagename = String(cString: sqlite3_column_text(stmt, 6))
            if let blobData = sqlite3_column_blob(stmt, 7){
                let blobLength = sqlite3_column_bytes(stmt, 7)
                let image = Data(bytes: blobData, count: Int(blobLength))
                imageData = image
            }
            let invalidate = String(cString: sqlite3_column_text(stmt, 8))
            
            locations.append(TodoList_SQLite(seq: seq, userid: id, title: title, content: content, insertdate: insertdate, isshare: isshare, imagename: imagename, image: imageData!, invalidate: invalidate))
        }
        sqlite3_finalize(stmt)
        DispatchQueue.main.async {
            self.delegate.downloadItem(items: locations)
        }
    }
    
    func selectIDShareDB(id: String, isshare: String){
        var stmt: OpaquePointer?
        var locations: [TodoList_SQLite] = []
        var imageData: Data?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "SELECT * FROM todolist WHERE userid = ? AND isshare = ?"
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        sqlite3_bind_text(stmt, 1, id, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 2, isshare, -1, SQLITE_TRANSIENT)
        
        while (sqlite3_step(stmt) == SQLITE_ROW){
            let seq = String(cString: sqlite3_column_text(stmt, 0))
            let id = String(cString: sqlite3_column_text(stmt, 1))
            let title = String(cString: sqlite3_column_text(stmt, 2))
            let content = String(cString: sqlite3_column_text(stmt, 3))
            let insertdate = String(cString: sqlite3_column_text(stmt, 4))
            let isshare = String(cString: sqlite3_column_text(stmt, 5))
            let imagename = String(cString: sqlite3_column_text(stmt, 6))
            if let blobData = sqlite3_column_blob(stmt, 7){
                let blobLength = sqlite3_column_bytes(stmt, 7)
                let image = Data(bytes: blobData, count: Int(blobLength))
                imageData = image
            }
            let invalidate = String(cString: sqlite3_column_text(stmt, 8))
            
            locations.append(TodoList_SQLite(seq: seq, userid: id, title: title, content: content, insertdate: insertdate, isshare: isshare, imagename: imagename, image: imageData!, invalidate: invalidate))
        }
        sqlite3_finalize(stmt)
        DispatchQueue.main.async {
            self.delegate.downloadItem(items: locations)
        }
    }
    
    func deleteDB(_ seq: String, id:String) -> (Bool){
        var stmt: OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "UPDATE todolist SET invalidate = 1 WHERE seq = ? AND userid = ?"
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        sqlite3_bind_text(stmt, 1, seq, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 2, id, -1, SQLITE_TRANSIENT)
        //        sqlite3_step(stmt)
        
        if sqlite3_step(stmt) == SQLITE_DONE{
            return true
        }else{
            return false
        }
    }
    
    func insertDB(_ todo: TodoList_SQLite) -> (Bool){
        var stmt: OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "INSERT INTO todolist (userid, title, content, insertdate, isshare, imagename, image, invalidate) VALUES (?, ?, ?, ?, ?, ?, ?, 0)"
        
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        sqlite3_bind_text(stmt, 1, todo.userid, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 2, todo.title, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 3, todo.content, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 4, todo.insertdate, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 5, todo.isshare, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 6, todo.imagename, -1, SQLITE_TRANSIENT)
        sqlite3_bind_blob(stmt, 7, (todo.image as NSData).bytes, Int32(todo.image.count), SQLITE_TRANSIENT)
        
        if sqlite3_step(stmt) == SQLITE_DONE{
            sqlite3_finalize(stmt)
            return true
        }else{
            sqlite3_finalize(stmt)
            return false
        }

    }
    
    func updateDB(_ todo: TodoList_SQLite) -> Bool{
        var stmt: OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "UPDATE todolist SET title = ?, content = ?, isshare = ?, imagename = ?, image = ? WHERE userid = ? AND seq = ?"
        
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        sqlite3_bind_text(stmt, 1, todo.title, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 2, todo.content, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 3, todo.isshare, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 4, todo.imagename, -1, SQLITE_TRANSIENT)
        sqlite3_bind_blob(stmt, 5, (todo.image as NSData).bytes, Int32(todo.image.count), SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 6, todo.userid, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 7, todo.seq, -1, SQLITE_TRANSIENT)
        
        if sqlite3_step(stmt) == SQLITE_DONE{
            return true
        }else{
            return false
        }
    }
    
    func updateShareDB(_ id: String) -> Bool{
        var stmt: OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "UPDATE todolist SET isshare = 0 WHERE userid = ?"
        
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        sqlite3_bind_text(stmt, 1, id, -1, SQLITE_TRANSIENT)
        
        if sqlite3_step(stmt) == SQLITE_DONE{
            return true
        }else{
            return false
        }
    }
    
}
