//
//  LoginViewController.swift
//  TodoList_TripleDB
//
//  Created by Okrie on 2023/08/28.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var tfID: UITextField!
    @IBOutlet weak var tfPW: UITextField!
    
    var userData: UserData_MySQL?
    var loginCheck: Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        guard let id: String = tfID.text?.trimmingCharacters(in: .whitespaces) else { alertActions(title: "Login", message: "Input ID"); return }
        guard let pw: String = tfPW.text?.trimmingCharacters(in: .whitespaces) else { alertActions(title: "Login", message: "Input PW"); return }
        
        let queryModel = UserDataDB_MySQL()
        queryModel.delegate = self
        queryModel.loginUser(id, pw)
        
    }
    
    @IBAction func btnRegister(_ sender: UIButton) {
        //
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func alertActions(title:String, message:String){
        let alertAction = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: .default, handler: {ACTION in
            if self.loginCheck == 1{
                Message.id = self.tfID.text!
                if let tabController = self.storyboard?.instantiateViewController(withIdentifier: "mainView") as? UITabBarController{
                    tabController.selectedIndex = 0
                    // 적절한 UIWindowScene에서 rootViewController를 설정하여 화면을 변경
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let windowDelegate = windowScene.delegate as? SceneDelegate {
                        windowDelegate.window?.rootViewController = tabController
                        windowDelegate.window?.makeKeyAndVisible()
                    }
                }
            }
        })
        
        alertAction.addAction(okAction)
        present(alertAction, animated: true)
    }
}

extension LoginViewController: QueryModelUserDataMySQLProtocol{
    func shareUserList(items: [ShareUserJSON]) {
        //
    }
    
    func loginUserList(count: Int) {
        self.loginCheck = count
        if loginCheck == 1 {
            alertActions(title: "Login", message: "Welcome \(tfID.text!)!")
            
        } else{
            alertActions(title: "Login", message: "Wrong ID or PW")
        }
    }
    
    func dupliUserList(count: Int) {
        //
    }
    
    
}
