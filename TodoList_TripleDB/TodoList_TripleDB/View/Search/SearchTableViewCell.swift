//
//  SearchTableViewCell.swift
//  TodoList_TripleDB
//
//  일정 검색 뷰의 Cell UI 연결
// 
//
//  Created by Okrie on 2023/08/29.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
