//
//  MyTableViewCell.swift
//  TodoList_TripleDB
//
//  Todolist 메인 뷰에 할당된 Cell에 이미지, 라벨 연결
//  넘겨 받은 데이터를 연결
//
//  Created by Okrie on 2023/08/28.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var myCellimageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!

    var data: TodoList_MySQL = TodoList_MySQL(seq: 0, userid: "", title: "", content: "", insertdate: "", isshare: "", imagename: "", invalidate: "")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblTitle.text = data.title

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
