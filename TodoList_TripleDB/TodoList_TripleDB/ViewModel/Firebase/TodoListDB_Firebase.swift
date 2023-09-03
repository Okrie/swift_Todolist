//
//  TodoListDB_Firebase.swift
//  TodoList_TripleDB
//
//  Firebase 사용을 위한 ViewModel
//  일정을 Firebase에 insert, select, update를 하기 위한 뷰모델
//  extension 으로 사용하기 위해 protocol로 선언하여 사용
//  delete구문이 없는 이유는 완전 삭제가 아닌 히스토리를 남기기 위해 update를 통해 invalidate 값만 변경하여 관리
//
//  Created by Okrie on 2023/08/29.
//

import Foundation
import Firebase

protocol QueryModelTodoListFirebaseProtocol{
    func itemDownloaded(items: [TodoList_Firebase])
}

class TodoListDB_Firebase{
    var delegate: QueryModelTodoListFirebaseProtocol!
    let db = Firestore.firestore()
    
    func downloadItems(){
        var locations: [TodoList_Firebase] = []
        
        db.collection("todolist").order(by: "userid").getDocuments(completion: {(querySnapshot, err) in
            if let err = err{
                print("Error getting documents: \(err)")
            } else{
                print("Data is downloaded")
                
                for document in querySnapshot!.documents{
                    guard let data = document.data()["seq"] else { return }
                    print("\(document.documentID) => \(data)")
                    let query = TodoList_Firebase(documentId: document.documentID, seq: document.data()["seq"] as! String, userid: document.data()["userid"] as! String, title: document.data()["title"] as! String, content: document.data()["content"] as! String, insertdate: document.data()["insertdate"] as! String, isshare: document.data()["isshare"] as! String, imagename: document.data()["imagename"] as! String)
                    locations.append(query)
                }
                
                DispatchQueue.main.async {
                    self.delegate.itemDownloaded(items: locations)
                }
            }
        })
    }
    
    func insertItems(data: TodoList_Firebase) -> Bool{
        var status: Bool = true
        
        db.collection("todolist").addDocument(data: [
            "userid" : data.userid,
            "title" : data.title,
            "content" : data.content,
            "insertdate" : data.insertdate,
            "isshare" : data.isshare,
            "imagename" : data.imagename
        ]){error in
            if error != nil{
                status = false
            } else{
                status = true
            }
        }
        return status
    }
    
    
    func updateItems(data: TodoList_Firebase) -> Bool{
        var status: Bool = true
        
        db.collection("todolist").document(data.documentId).updateData([
            "seq" : data.seq,
            "userid" : data.userid,
            "title" : data.title,
            "content" : data.content,
            "insertdate" : data.insertdate,
            "isshare" : data.isshare,
            "imagename" : data.imagename
        ]){
            error in
            if error != nil{
                status = false
            }else{
                status = true
            }
        }
        return status
    }
    
    func deleteItems(documentId: String) -> Bool{
        var status: Bool = true
        
        db.collection("todolist").document(documentId).updateData([
            "invalidate" : 1
        ]){
            error in
            if error != nil{
                status = false
            }else{
                status = true
            }
        }
        
        return status
    }
}
