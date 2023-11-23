//
//  FriendInfoCell.swift
//  KoKoFriend
//
//  Created by Victor on 2023/11/23.
//

import UIKit

class FriendInfoCell: UITableViewCell {
    
    @IBOutlet weak var starBtn: UIButton!
    @IBOutlet weak var avatorImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var transferBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var moreBtnWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var lineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatorImgView.layer.cornerRadius = 20
        avatorImgView.image = UIImage(named: "imgFriendsFemaleDefault")
        nameLabel.textColor = .greyishBrown
        transferBtn.layer.borderColor = UIColor.hotPink.cgColor
        transferBtn.layer.borderWidth = 1
        transferBtn.layer.cornerRadius = 2
        transferBtn.setTitleColor(.hotPink, for: .normal)
        moreBtn.setImage(UIImage(named: "icFriendsMore"), for: .normal)
        lineView.backgroundColor = .whiteThree
        self.selectionStyle = .none
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUpCellStatus(isTop:String,status:Int){
        
        starBtn.isHidden = isTop == "0" ? false : true
        if status == 1 {
        moreBtn.layer.borderWidth = 0
          moreBtn.setImage(UIImage(named: "icFriendsMore"), for: .normal)
            moreBtnWidthConstraint.constant = 18
        }else if status == 2{
            moreBtn.layer.borderWidth = 1
            moreBtn.layer.borderColor = UIColor.brownGrey.cgColor
            moreBtn.titleLabel?.textColor = .brownGrey
            moreBtn.layer.cornerRadius = 2
            moreBtn.setTitle("邀請中", for: .normal)
            moreBtn.setImage(nil, for: .normal)
            moreBtnWidthConstraint.constant = 60
           
        }
    }
    
}
