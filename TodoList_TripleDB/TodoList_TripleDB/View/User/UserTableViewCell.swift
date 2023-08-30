//
//  UserTableViewCell.swift
//  TodoList_TripleDB
//
//  Created by Okrie on 2023/08/29.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var receiveData: TodoList_SQLite = TodoList_SQLite(seq: "", userid: "", title: "", content: "", insertdate: "", isshare: "", imagename: "", image: Data(), invalidate: "")

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
