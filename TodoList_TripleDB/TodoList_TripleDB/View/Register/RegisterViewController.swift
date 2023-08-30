//
//  RegisterViewController.swift
//  TodoList_TripleDB
//
//  User Register를 위한 뷰
//  ID 값은 db에서 가져온 값으로 비교하여 입력시에 실시간 가입 가능한 ID인지 판별
//  PW 는 두개의 입력 값이 같은지 아닌지 비교
//  유저의 일정 공유 유무를 Switch 로 구분
//  위 조건을 만족 할 시 Register 버튼 활성화
//  button 실행시 정상 정보 일 시 DB에 insert
//
//  Created by Okrie on 2023/08/28.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var tfID: UITextField!
    @IBOutlet weak var tfPW1: UITextField!
    @IBOutlet weak var tfPW2: UITextField!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var lblSwitch: UILabel!
    @IBOutlet weak var btnRegisterOutlet: UIButton!
    
    var swDis: Bool = true
    var isShare: String = ""
    
    var userData: UserData_MySQL?
    let queryModel = UserDataDB_MySQL()
    var dupleCheck: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        btnRegisterOutlet.isEnabled = false
        queryModel.delegate = self
        
        self.tfID.addTarget(self, action: #selector(self.viewReload(_ :)), for: .editingChanged)
        self.tfPW1.addTarget(self, action: #selector(self.viewReload(_ :)), for: .editingChanged)
        self.tfPW2.addTarget(self, action: #selector(self.viewReload(_ :)), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    
    @objc func viewReload(_ sender:Any?) {
        var result: Bool = false
        if !tfID.text!.trimmingCharacters(in: .whitespaces).isEmpty && !tfPW1.text!.trimmingCharacters(in: .whitespaces).isEmpty && !tfPW2.text!.trimmingCharacters(in: .whitespaces).isEmpty{
            if tfPW1.text!.trimmingCharacters(in: .whitespaces) == tfPW2.text!.trimmingCharacters(in: .whitespaces){
                queryModel.dupliUser(tfID.text!)
                
                if dupleCheck == 0{
                    lblResult.text = "Can Register!"
                    lblResult.textColor = .blue
                    result = true
                } else{

                    lblResult.text = "Check Another ID"
                    lblResult.textColor = .red
                    result = false
                }
            } else{
                lblResult.text = "Check Password and Repeat Password"
                lblResult.textColor = .red
                result = false
            }
        } else{
            lblResult.text = "Input All Field"
            lblResult.textColor = .red
            result = false
        }
        
        if result{
            btnRegisterOutlet.isEnabled = true
        } else{
            btnRegisterOutlet.isEnabled = false
        }
    }
    
    @IBAction func swDisclosure(_ sender: UISwitch) {
        swDis = sender.isOn
        lblSwitch.text = swDis ? "Public" : "Private"
        isShare = swDis ? "1" : "0"
    }
    
    @IBAction func btnRegister(_ sender: UIButton) {
        _ = queryModel.insertDB(UserData_MySQL(userid: tfID.text!, userpw: tfPW1.text!, insertdate: self.dateNow(), invalidate: "0", isshare: isShare))
        
        alertActions(title: "Sign Up", message: "Welcome Sign up!")
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func dateNow() -> String{
        let now = Date()

        let date = DateFormatter()
        date.locale = Locale(identifier: "ko_kr")
        date.timeZone = TimeZone(abbreviation: "KST") // "2018-03-21 18:07:27"
        //date.timeZone = TimeZone(abbreviation: "NZST") // "2018-03-21 22:06:39"
        date.dateFormat = "yyyyMMddHHmm"

        let kr = date.string(from: now)
        print(kr)
        return kr
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
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
            self.navigationController?.popViewController(animated: true)
        })
        
        alertAction.addAction(okAction)
        present(alertAction, animated: true)
    }

}

extension RegisterViewController: QueryModelUserDataMySQLProtocol{
    func shareUserList(items: [ShareUserJSON]) {
        //
    }
    
    func loginUserList(count: Int) {
        //
    }
    
    func dupliUserList(count: Int) {
        self.dupleCheck = count
    }
    
    
}
