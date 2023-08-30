//
//  DetailViewController.swift
//  TodoList_TripleDB
//
//  Created by Okrie on 2023/08/26.
//

import UIKit

class MyDetailViewController: UIViewController {
    
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfContext: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var swDis: UISwitch!
    @IBOutlet weak var lblSwitch: UILabel!
    
    let picker = UIImagePickerController()
    
//    var receiveData: TodoList_MySQL = TodoList_MySQL(seq: 0, userid: "", title: "", content: "", insertdate: "", isshare: "", imagename: "", invalidate: "")
    var receiveData: TodoList_SQLite = TodoList_SQLite(seq: "", userid: "", title: "", content: "", insertdate: "", isshare: "", imagename: "", image: Data(), invalidate: "")
    var swOn: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        tfTitle.text = receiveData.title
        tfContext.text = receiveData.content
        swDis.isOn = receiveData.isshare == "1" ? true : false
        lblSwitch.text = swDis.isOn ? "Public" : "Private"
        imgView.image = UIImage(data: receiveData.image)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func swDisc(_ sender: UISwitch) {
        swOn = sender.isOn
        lblSwitch.text = swOn ? "Public" : "Private"
    }
    
    @IBAction func btnEditImg(_ sender: UIButton) {
        let alert =  UIAlertController(title: "Upload Image", message: "", preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "Album", style: .default) { ACTION in
            self.openLibrary()}
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(library)
        alert.addAction(cancel)
 
        present(alert, animated: true, completion: nil)
    }
    
    func openLibrary(){
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
//        let queryModel = TodoListDB_MYSQL()
//        queryModel.delegate = self
//        _ = queryModel.updateDB(TodoList_MySQL(seq: receiveData.seq, userid: Message.id, title: self.lblTitle.text!, content: self.lblContent.text!, insertdate: "", isshare: swOn ? "1" : "0", imagename: "", invalidate: "0"))
        
        
        let queryModel = TodoListDB_SQLITE()
        queryModel.delegate = self
        _ = queryModel.updateDB(TodoList_SQLite(seq: receiveData.seq, userid: Message.id, title: tfTitle.text!, content: tfContext.text!, insertdate: receiveData.insertdate, isshare: swOn ? "1" : "0", imagename: receiveData.imagename, image: receiveData.image, invalidate: receiveData.invalidate))
        alertActions(title: "Update", message: "Success Update")
    }
    
    @IBAction func btnDelete(_ sender: UIButton) {
//        let queryModel = TodoListDB_MYSQL()
//        queryModel.delegate = self
//        _ = queryModel.deleteDB(receiveData.userid, seq: receiveData.seq)
        let queryModel = TodoListDB_SQLITE()
        queryModel.delegate = self
        _ = queryModel.deleteDB(receiveData.seq, id: Message.id)
        alertActions(title: "Delete", message: "Success Delete")
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
            self.navigationController?.popViewController(animated: true)
        })
        
        alertAction.addAction(okAction)
        present(alertAction, animated: true)
    }
}

extension MyDetailViewController: QueryModelTodoListMySQLProtocol{
    func downloadItem(items: [TodoList_MySQL]) {
        //
    }
}

extension MyDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage{
            if let imageData = pickedImage.pngData(){
                receiveData.image = imageData
                imgView.image = pickedImage
            }
        }
        
        if let imageUrl = info[.imageURL] as? URL{
            let imageName = imageUrl.absoluteString
            receiveData.imagename = imageName
            print(imageName)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension MyDetailViewController: QueryModelSQLiteProtocol{
    func downloadItem(items: [TodoList_SQLite]) {
        //
    }

}
