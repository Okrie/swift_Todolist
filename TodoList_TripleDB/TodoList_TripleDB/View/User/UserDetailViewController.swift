//
//  UserDetailViewController.swift
//  TodoList_TripleDB
//
//  Created by Okrie on 2023/08/26.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblContext: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblUser: UILabel!

    var receivedDetailData: TodoList_SQLite = TodoList_SQLite(seq: "", userid: "", title: "", content: "", insertdate: "", isshare: "", imagename: "", image: Data(), invalidate: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblUser.text = "\(receivedDetailData.userid)'s TodoList"
        lblTitle.text = receivedDetailData.title
        lblContext.text = receivedDetailData.content
        imgView.image = UIImage(data: receivedDetailData.image)
        // Do any additional setup after loading the view.
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
