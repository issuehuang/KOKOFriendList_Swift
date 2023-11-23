//
//  ViewController.swift
//  KoKoFriend
//
//  Created by Victor on 2023/11/19.
//

import UIKit
enum dataType {
    case noFriend
    case friendButNoInvite
    case friendAndInvite
}


class ViewController: UIViewController {
    @IBOutlet weak var noFriendsBtn: GradientButton!
    
    @IBOutlet weak var friendButNoInviteBtn: GradientButton!
    
    @IBOutlet weak var friendAndInviteBtn: GradientButton!
    
    lazy var friendBtns:[GradientButton] = {
        return [noFriendsBtn,friendButNoInviteBtn,friendAndInviteBtn]
    }()
    var viewModel = FriendListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        friendBtns.forEach { btn in
            btn.startPoint = CGPoint(x: 0, y: 0.5)
            btn.endPoint = CGPoint(x: 1, y: 0.5)
            btn.colors = [UIColor.frogGreen.cgColor,UIColor.booger.cgColor]
            btn.titleLabel?.textColor = .white
            btn.tintColor = .white
        }
        noFriendsBtn.addTarget(self, action: #selector(tapNoFriendBtn), for: .touchUpInside)
        friendButNoInviteBtn.addTarget(self, action: #selector(tapFriendButNoInviteBtn), for: .touchUpInside)
        friendAndInviteBtn.addTarget(self, action: #selector(tapFriendAndInviteBtn), for: .touchUpInside)


    }

    @objc func tapNoFriendBtn(){
        UserManager.shared.apiType = .noFriend
        self.tabBarController?.selectedIndex = 1
    }
    @objc func tapFriendButNoInviteBtn(){
        UserManager.shared.apiType = .friendButNoInvite
        viewModel.fetchDataType = .friendButNoInvite

        self.tabBarController?.selectedIndex = 1
       
    }
    @objc func tapFriendAndInviteBtn(){
        UserManager.shared.apiType = .friendAndInvite
        viewModel.fetchDataType = .friendAndInvite
        self.tabBarController?.selectedIndex = 1
    }
}

