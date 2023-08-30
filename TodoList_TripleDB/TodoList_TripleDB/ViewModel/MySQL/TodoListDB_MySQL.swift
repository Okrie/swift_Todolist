//
//  TodoListDB_MySQL.swift
//  TodoList_TripleDB
//
//  Created by Okrie on 2023/08/28.
//

import Foundation

protocol QueryModelTodoListMySQLProtocol{
    func downloadItem(items: [TodoList_MySQL])
}

class TodoListDB_MYSQL{
    var db: OpaquePointer?
    var urlPath = "http://localhost:8080/ios/"
    var imgUrl = "http://localhost:8080/images/"
    var todoList: [TodoList_MySQL] = []
    var delegate: QueryModelTodoListMySQLProtocol!
    
    func selectAllDB(_ id: String){
        let urlSuffix: String = "?userid=\(id)&invalidate=0"
        let urlQuery: URL = URL(string: self.urlPath + "todolist_query_ios.jsp" + urlSuffix)!

        DispatchQueue.global().async {
            do{
                let data = try Data(contentsOf: urlQuery)
                DispatchQueue.main.async {
                    self.parseTodoListJSON(data)
                }
            } catch {
                print("Doesn't have TodoList")
            }
        }
    }
    
    func parseTodoListJSON(_ data: Data){
        let decoder = JSONDecoder()
        var locations: [TodoList_MySQL] = []
        
        do{
            let todolists = try decoder.decode(TodoListResults.self, from: data)
            for todo in todolists.results{
                let query = TodoList_MySQL(seq: todo.seq, userid: todo.userid, title: todo.title, content: todo.content, insertdate: todo.insertdate, isshare: todo.isshare, imagename: todo.imagename, invalidate: todo.invalidate)
                locations.append(query)
            }
            
        } catch let error{
            print("Failed: \(error.localizedDescription)")
        }
        
        DispatchQueue.main.async {
            self.delegate.downloadItem(items: locations)
        }
    }
    
    func deleteDB(_ id: String, seq:Int) -> (Bool){
        var result: Bool = true
        let urlSuffix: String = "?userid=\(id)&seq=\(seq)"
        let urlDelete: URL = URL(string: self.urlPath + "todolist_delete_return_ios.jsp" + urlSuffix)!
        
        DispatchQueue.global().async {
            do{
                _ = try Data(contentsOf: urlDelete)
                DispatchQueue.main.async {
                    result = true
                }
            }catch{
                result = false
                print("Failed Delete")
            }
        }
        
        return result
    }
    
    func insertDB(_ todo: TodoList_MySQL) -> (Bool){
        var result: Bool = true
        let urlSuffix: String = "?userid=\(todo.userid)&title=\(todo.title)&invalidate=0&isshare=\(todo.isshare)&insertdate=\(todo.insertdate)&imagename=\(todo.imagename)&content=\(todo.content)"
        let urlInsert: URL = URL(string: self.urlPath + "todolist_insert_ios.jsp" + urlSuffix)!
        
        DispatchQueue.global().async {
            do{
                _ = try Data(contentsOf: urlInsert)
                DispatchQueue.main.async {
                    result = true
                }
            }catch{
                result = false
                print("Failed Insert")
            }
        }
        
        return result
    }
    
    func updateDB(_ todo: TodoList_MySQL) -> Bool{
        var result: Bool = true
        let urlSuffix: String = "?userid=\(todo.userid)&title=\(todo.title)&invalidate=0&isshare=\(todo.isshare)&imagename=\(todo.imagename)&content=\(todo.content)"
        let urlUpdate: URL = URL(string: self.urlPath + "todolist_update_ios.jsp" + urlSuffix)!
        
        DispatchQueue.global().async {
            do{
                _ = try Data(contentsOf: urlUpdate)
                DispatchQueue.main.async {
                    result = true
                }
            }catch{
                result = false
                print("Failed Update")
            }
        }
        
        return result
    }
    
}
