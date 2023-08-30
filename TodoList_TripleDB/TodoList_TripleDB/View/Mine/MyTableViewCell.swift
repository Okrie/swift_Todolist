//
//  MyTableViewCell.swift
//  TodoList_TripleDB
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
