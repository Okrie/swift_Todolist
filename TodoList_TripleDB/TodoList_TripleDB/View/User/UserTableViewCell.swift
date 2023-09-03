//
//  UserTableViewCell.swift
//  TodoList_TripleDB
//
//  유저 중 공유한 유저의 리스트 중 공유한 일정을 보여주는 뷰
//  공유한 일정의 정보를 연결시켜주는 Cell
//
//  Created by Okrie on 2023/08/29.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var receiveData: TodoList_SQLite = TodoList_SQLite(seq: "", userid: "", title: "", content: "", insertdate: "", isshare: "", imagename: "", image: Data(), invalidate: "", isfinished: "")

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
