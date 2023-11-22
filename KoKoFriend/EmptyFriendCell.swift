//
//  EmptyFriendCell.swift
//  KoKoFriend
//
//  Created by Victor on 2023/11/22.
//

import UIKit

class EmptyFriendCell: UITableViewCell {

    @IBOutlet weak var mainImg: UIImageView!
    
    @IBOutlet weak var greetinfLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var addFriendBtn: UIButton!
    
    @IBOutlet weak var helpLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
