//
//  InvitedCell.swift
//  KoKoFriend
//
//  Created by Victor on 2023/11/23.
//

import UIKit

class InvitedCell: UITableViewCell {

    @IBOutlet weak var avatorImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        avatorImgView.image = UIImage(named: "imgFriendsFemaleDefault")
        avatorImgView.layer.cornerRadius = 20
        nameLabel.textColor = .greyishBrown
        nameLabel.font = UIFont(name: "PingFangTC-Regular", size: 16)
        greetingLabel.textColor = .brownGrey
        greetingLabel.font =  UIFont(name: "PingFangTC-Regular", size: 13)
        greetingLabel.text = "邀請你成為好友：）"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
