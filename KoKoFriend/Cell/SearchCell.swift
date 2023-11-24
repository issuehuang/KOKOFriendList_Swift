//
//  SearchCell.swift
//  KoKoFriend
//
//  Created by Victor on 2023/11/22.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var textfield: SearchTextField!
    @IBOutlet weak var searchBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        textfield.leftViewMode = .always
        textfield.leftView = UIImageView(image: UIImage(named: "icSearchBarSearchGray"))
        
        textfield.backgroundColor = UIColor(red: 142/255, green: 142/255, blue: 142/255, alpha: 0.12)
        textfield.placeholder = "想轉一筆給誰呢？"
        textfield.layer.cornerRadius = 10
        textfield.clearButtonMode = .whileEditing
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

class SearchTextField: UITextField {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        leftViewMode = .always
        let imageView = UIImageView(image: UIImage(named: "icSearchBarSearchGray"))
        imageView.contentMode = .scaleAspectFit
        leftView = imageView
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let width = UIImage(named: "icSearchBarSearchGray")?.size.width ?? 0.0
        return CGRect(x: 10, y: 10, width: width, height: 14)
    }
}
