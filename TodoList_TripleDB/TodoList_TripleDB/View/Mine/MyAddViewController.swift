//
//  MyAddViewController.swift
//  TodoList_TripleDB
//
//
//  2023-09-03 v0.3
//  image Compression 0.6
//
//  2023-09-02 v0.2
//  Mysql Image Upload 기능 구현
//  Firebase Image Upload 기능 구현
//
//  2023-08-26 v0.1
//  Todolist 일정 추가를 위한 뷰
//  각 정보를 입력 받아 db에 내용 추가
//  이미지 업로드를 위한 extension 선언 및 구현
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
    var selectedImg: UIImage?
    let sqlQueryModel = TodoListDB_SQLITE()
//    let mysqlQueryModel = TodoListDB_MYSQL()
//    let fbQueryModel = TodoListDB_Firebase()
    var todoList: TodoList_SQLite?
//    var todoList: TodoList_MySQL?
//    var todoList: TodoList_Firebase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblImgName.text = ""
        todoList = TodoList_SQLite(seq: "", userid: "", title: "", content: "", insertdate: "", isshare: "", imagename: "", image: Data(), invalidate: "", isfinished: "")
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
        // MySQL
//        let queryModel = TodoListDB_MYSQL()
//        queryModel.delegate = self
//        _ = queryModel.insertDB(TodoList_MySQL(seq: 0, userid: Message.id, title: tfTitle.text!, content: tfContent.text!, insertdate: dateNow(), isshare: swOn ? "1" : "0", imagename: lblImgName.text!, invalidate: "0"))
        
        
        // 2023-09-02 서버에 ImageUpload 기능 추가
        // v0.2
        let imgUpload = ImageControl()
        imgUpload.uploadImageToJSP(image: selectedImg!, imageName: todoList!.imagename)
        
        // 2023-09-02 ImageUpload on Firebase
        // v0.2
//        let imgUpload_fb = ImageUpload_Firebase()
//        let downloadUrl = imgUpload_fb.uploadFile(image: selectedImg!, imageName: todoList!.imagename)
//
        // 2023-09-02 Firebase
        // v0.2
//        let result = fbQueryModel.insertItems(data: TodoList_Firebase(documentId: todoList.documentId!, seq: todoList!.seq, userid: todoList!.userid, title: todoList!.title, content: todoList!.content, insertdate: dateNow(), isshare: todoList!.isshare, imagename: downloadUrl))
        
        // SQLite
        let result = sqlQueryModel.insertDB(TodoList_SQLite(seq: "", userid: Message.id, title: tfTitle.text!, content: tfContent.text!, insertdate: dateNow(), isshare: swOn ? "1" : "0", imagename: todoList!.imagename, image: todoList!.image, invalidate: "0", isfinished: "0"))
        print("result = \(result)")
        self.navigationController?.popViewController(animated: true)
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
            // 2023-09-03 v0.3
            // compression image file
            if let compImage = pickedImage.jpegData(compressionQuality: 0.6){
                if let imageData = pickedImage.pngData(){
                    todoList?.image = imageData
                    imgView.image = UIImage(data: compImage)
                    self.selectedImg = UIImage(data: compImage)
                }
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
