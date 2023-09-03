//
//  UserDetailViewController.swift
//  TodoList_TripleDB
//
//  유저 중 공유한 유저의 리스트 중 공유한 일정 중 선택한 일정의 상세정보를 보여주는 뷰
//  수정은 불가능하며 보기만 가능
//
//  Created by Okrie on 2023/08/26.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblContext: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblUser: UILabel!

    var receivedDetailData: TodoList_SQLite = TodoList_SQLite(seq: "", userid: "", title: "", content: "", insertdate: "", isshare: "", imagename: "", image: Data(), invalidate: "", isfinished: "")

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
