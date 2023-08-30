//
//  UserSharedTableViewCell.swift
//  TodoList_TripleDB
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
