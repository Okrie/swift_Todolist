//
//  MyAddViewController.swift
//  TodoList_TripleDB
//
//  Created by Okrie on 2023/08/26.
//

import UIKit

class MyAddViewController: UIViewController {

    @IBOutlet weak var lblSw: UILabel!
    @IBOutlet weak var swDis: UISwitch!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfContent: UITextField!
    @IBOutlet weak var lblImgName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var swOn: Bool = false
    let sqlQueryModel = TodoListDB_SQLITE()
    var todoList: TodoList_SQLite?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblImgName.text = ""
        todoList = TodoList_SQLite(seq: "", userid: "", title: "", content: "", insertdate: "", isshare: "", imagename: "", image: Data(), invalidate: "")
        sqlQueryModel.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func swDisc(_ sender: UISwitch) {
        swOn = sender.isOn
        lblSw.text = swOn ? "Public" : "Private"
    }
    
    @IBAction func btnUpload(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.delegate = self
        present(imagePicker, animated: true)
        //
        
    }
    
    @IBAction func btnInsert(_ sender: UIButton) {
//        let queryModel = TodoListDB_MYSQL()
//        queryModel.delegate = self
//        _ = queryModel.insertDB(TodoList_MySQL(seq: 0, userid: Message.id, title: tfTitle.text!, content: tfContent.text!, insertdate: dateNow(), isshare: swOn ? "1" : "0", imagename: lblImgName.text!, invalidate: "0"))
        
        let result = sqlQueryModel.insertDB(TodoList_SQLite(seq: "", userid: Message.id, title: tfTitle.text!, content: tfContent.text!, insertdate: dateNow(), isshare: swOn ? "1" : "0", imagename: todoList!.imagename, image: todoList!.image, invalidate: "0"))
        print("result = \(result)")
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

}

extension MyAddViewController: QueryModelTodoListMySQLProtocol{
    func downloadItem(items: [TodoList_MySQL]) {
        //
    }
}

extension MyAddViewController: QueryModelSQLiteProtocol{
    func downloadItem(items: [TodoList_SQLite]) {
        //
    }
}

extension MyAddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage{
            if let imageData = pickedImage.pngData(){
                todoList?.image = imageData
                imgView.image = pickedImage
            }
        }
        
        if let imageUrl = info[.imageURL] as? URL{
            let imageName = imageUrl.absoluteString
            todoList?.imagename = imageName
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
