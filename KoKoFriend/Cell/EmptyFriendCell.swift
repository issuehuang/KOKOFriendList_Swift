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
    
    @IBOutlet weak var addFriendBtn: GradientButton!
    
    @IBOutlet weak var helpLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        addFriendBtn.startPoint = CGPoint(x: 0, y: 0.5)
        addFriendBtn.endPoint = CGPoint(x: 1, y: 0.5)
        addFriendBtn.colors = [UIColor(red: 86/255, green: 179/255, blue: 11/255, alpha: 1.0).cgColor,UIColor(red: 166/255, green: 204/255, blue: 66/255, alpha: 1.0).cgColor]
        addFriendBtn.titleLabel?.textColor = .white
        addFriendBtn.tintColor = .white
        addFriendBtn.semanticContentAttribute = .forceRightToLeft
        addFriendBtn.layer.cornerRadius = 20
        addFriendBtn.clipsToBounds = true
        addFriendBtn.setImage(UIImage(named: "icAddFriendWhite"), for: .normal)
        addFriendBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -100)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


class GradientButton: UIButton {
    var startPoint: CGPoint = CGPoint.zero
    var endPoint: CGPoint = CGPoint.zero
    var colors: [CGColor] = []

    lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = colors
        self.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}

extension UIColor {
    @nonobjc class var kokoPink:UIColor {
        return UIColor(red: 236/255, green: 0, blue: 140/255, alpha: 1.0)
    }
    
    @nonobjc class var appleGreen: UIColor {
       return UIColor(red: 121.0 / 255.0, green: 196.0 / 255.0, blue: 27.0 / 255.0, alpha: 1.0)
     }
     @nonobjc class var brownGrey: UIColor {
       return UIColor(white: 153.0 / 255.0, alpha: 1.0)
     }
     @nonobjc class var softPink: UIColor {
       return UIColor(red: 249.0 / 255.0, green: 178.0 / 255.0, blue: 220.0 / 255.0, alpha: 1.0)
     }
     @nonobjc class var steel: UIColor {
       return UIColor(red: 142.0 / 255.0, green: 142.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0)
     }
     @nonobjc class var whiteThree: UIColor {
       return UIColor(white: 228.0 / 255.0, alpha: 1.0)
     }
     @nonobjc class var appleGreen40: UIColor {
       return UIColor(red: 121.0 / 255.0, green: 196.0 / 255.0, blue: 27.0 / 255.0, alpha: 0.4)
     }
     @nonobjc class var greyishBrown: UIColor {
       return UIColor(white: 71.0 / 255.0, alpha: 1.0)
     }
     @nonobjc class var steel12: UIColor {
       return UIColor(red: 142.0 / 255.0, green: 142.0 / 255.0, blue: 147.0 / 255.0, alpha: 0.12)
     }
     @nonobjc class var pinkishGrey: UIColor {
       return UIColor(white: 201.0 / 255.0, alpha: 1.0)
     }
     @nonobjc class var black10: UIColor {
       return UIColor(white: 0.0, alpha: 0.1)
     }
     @nonobjc class var booger: UIColor {
       return UIColor(red: 166.0 / 255.0, green: 204.0 / 255.0, blue: 66.0 / 255.0, alpha: 1.0)
     }
     @nonobjc class var frogGreen: UIColor {
       return UIColor(red: 86.0 / 255.0, green: 179.0 / 255.0, blue: 11.0 / 255.0, alpha: 1.0)
     }
     @nonobjc class var hotPink: UIColor {
       return UIColor(red: 236.0 / 255.0, green: 0.0, blue: 140.0 / 255.0, alpha: 1.0)
     }

    
}
