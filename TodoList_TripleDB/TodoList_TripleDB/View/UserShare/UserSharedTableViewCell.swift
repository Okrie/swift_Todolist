//
//  UserSharedTableViewCell.swift
//  TodoList_TripleDB
//
//  유저 중 공유한 유저의 리스트를 정보를 담고 있는 Cell
//  필요한 내용을 연결
//
//
//  Created by Okrie on 2023/08/29.
//

import UIKit

class UserSharedTableViewCell: UITableViewCell {

    @IBOutlet weak var lblUserInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
