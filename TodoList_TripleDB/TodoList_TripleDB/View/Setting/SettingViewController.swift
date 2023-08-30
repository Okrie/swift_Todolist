//
//  SettingViewController.swift
//  TodoList_TripleDB
//
//  Created by Okrie on 2023/08/26.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var lblSwitch: UILabel!
    @IBOutlet weak var swisOn: UISwitch!
    
    var swOn: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        let queryModel = UserDataDB_MySQL()
        queryModel.delegate = self
        queryModel.shareUser()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func swDis(_ sender: UISwitch) {
        swOn = sender.isOn
        lblSwitch.text = swOn ? "Public" : "Private"
        
        let queryModel = UserDataDB_MySQL()
        queryModel.delegate = self
        DispatchQueue.main.async {
            _ = queryModel.updateDB(UserData_MySQL(userid: Message.id, userpw: "", insertdate: "", invalidate: "0", isshare: self.swOn ? "1" : "0"))
        }
    }
        
    
    @IBAction func btnShareUpdate(_ sender: UIButton) {
        let queryModel = TodoListDB_SQLITE()
        queryModel.delegate = self
        _ = queryModel.updateShareDB(Message.id)
        alertActions(title: "Settings", message: "All TodoList is Private Now")
    }
    
    func alertActions(title:String, message:String){
        let alertAction = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertAction.addAction(okAction)
        present(alertAction, animated: true)
    }
    
    @IBAction func btnLogout(_ sender: UIButton) {
        let alertAction = UIAlertController(title: "Logout", message: "Do you want a Logout?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Logout", style: .default, handler: {ACTION in
            Message.id = ""
            if let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "loginView") as? UIViewController{

                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let windowDelegate = windowScene.delegate as? SceneDelegate {
                    windowDelegate.window?.rootViewController = loginViewController
                    windowDelegate.window?.makeKeyAndVisible()
                }
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alertAction.addAction(okAction)
        alertAction.addAction(cancelAction)
        present(alertAction, animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingViewController: QueryModelSQLiteProtocol{
    func downloadItem(items: [TodoList_SQLite]) {
        //
    }
    
}

extension SettingViewController: QueryModelUserDataMySQLProtocol{
    func shareUserList(items: [ShareUserJSON]) {
        let queryShare = items
        var filterd: Bool = false
        filterd = queryShare.filter{$0.userid.localizedStandardContains(Message.id)}.isEmpty ? false : true
        swisOn.isOn = filterd
        lblSwitch.text = filterd ? "Public" : "Private"
    }
    
    func loginUserList(count: Int) {
        //
    }
    
    func dupliUserList(count: Int) {
        //
    }
    
    
}
