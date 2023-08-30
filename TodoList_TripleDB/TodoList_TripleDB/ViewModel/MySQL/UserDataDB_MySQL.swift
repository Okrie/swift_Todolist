//
//  UserDataDB_Mysql.swift
//  TodoList_TripleDB
//
//  MySql 사용을 위한 ViewModel
//  유저 정보를 MySql에 insert, select, update를 하기 위한 뷰모델
//  extension 으로 사용하기 위해 protocol로 선언하여 사용
//  delete구문이 없는 이유는 완전 삭제가 아닌 히스토리를 남기기 위해 update를 통해 invalidate 값만 변경하여 관리
//
//  Created by Okrie on 2023/08/28.
//

import Foundation

protocol QueryModelUserDataMySQLProtocol{
    func shareUserList(items: [ShareUserJSON])
    func loginUserList(count: Int)
    func dupliUserList(count: Int)
}

class UserDataDB_MySQL{
    var db: OpaquePointer?
    var urlPath = "http://localhost:8080/ios/"
    var userData: UserData_MySQL?
    var delegate: QueryModelUserDataMySQLProtocol!
    
    func shareUser(){
        let urlQuery: URL = URL(string: self.urlPath + "userdata_share_ios.jsp")!

        DispatchQueue.global().async {
            do{
                let data = try Data(contentsOf: urlQuery)
                DispatchQueue.main.async {
                    self.parseShareUserJSON(data)
                }
            } catch{
                
            }
        }
    }

    private func parseShareUserJSON(_ data: Data){
        let decoder = JSONDecoder()
        var locations: [ShareUserJSON] = []

        do{
            let userdata = try decoder.decode(ShareUserResult.self, from: data)
            for user in userdata.results{
                let query = ShareUserJSON(userid: user.userid)
                locations.append(query)
            }

        } catch let error{
            print("Failed: \(error.localizedDescription)")
        }

        DispatchQueue.main.async {
            self.delegate.shareUserList(items: locations)
        }
    }
    
    func loginUser(_ id: String, _ pw: String){
        let urlSuffix: String = "?userid=\(id)&userpw=\(pw)"
        let urlQuery: URL = URL(string: self.urlPath + "userdata_login_ios.jsp" + urlSuffix)!

        DispatchQueue.global().async {
            do{
                let data = try Data(contentsOf: urlQuery)
                DispatchQueue.main.async {
                    self.parseloginUserJSON(data)
                }
            } catch{
                print("err")
            }
        }
    }

    private func parseloginUserJSON(_ data: Data){
        let decoder = JSONDecoder()
        var locations: Int = 0

        do{
            let userdata = try decoder.decode(LoginUserJSON.self, from: data)
            locations = userdata.count
            
        } catch let error{
            print("Failed: \(error.localizedDescription)")
        }

        DispatchQueue.main.async {
            self.delegate.loginUserList(count: locations)
        }
    }
    
    func dupliUser(_ id: String){
        let urlSuffix: String = "?userid=\(id)"
        let urlQuery: URL = URL(string: self.urlPath + "userdata_duplicate_ios.jsp" + urlSuffix)!

        DispatchQueue.global().async {
            do{
                let data = try Data(contentsOf: urlQuery)
                DispatchQueue.main.async {
                    self.parseDupliUserJSON(data)
                }
            } catch{
                print("err")
            }
        }
    }

    private func parseDupliUserJSON(_ data: Data){
        let decoder = JSONDecoder()
        var locations: Int?

        do{
            let userdata = try decoder.decode(DupliUserJSON.self, from: data)
            locations = userdata.count
        } catch let error{
            print("Failed: \(error.localizedDescription)")
        }

        DispatchQueue.main.async {
            self.delegate.dupliUserList(count: locations!)
        }
    }
    
    func deleteDB(_ id: String) -> (Bool){
        var result: Bool = true
        let urlSuffix: String = "?userid=\(id)"
        let urlDelete: URL = URL(string: self.urlPath + "userdata_delete_return_ios.jsp" + urlSuffix)!
        
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
    
    func insertDB(_ user: UserData_MySQL) -> (Bool){
        var result: Bool = true
        let urlSuffix: String = "?userid=\(user.userid)&userpw=\(user.userpw)&invalidate=0&isshare=\(user.isshare)&insertdate=\(user.insertdate)"
        let urlInsert: URL = URL(string: self.urlPath + "userdata_insert_ios.jsp" + urlSuffix)!
        
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
    
    func updateDB(_ user: UserData_MySQL) -> Bool{
        var result: Bool = true
        let urlSuffix: String = "?userid=\(user.userid)&invalidate=\(user.invalidate)&isshare=\(user.isshare)"
        let urlUpdate: URL = URL(string: self.urlPath + "userdata_update_return_ios.jsp" + urlSuffix)!
        
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
