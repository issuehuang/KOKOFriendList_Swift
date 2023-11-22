//
//  FriendPageViewController.swift
//  KoKoFriend
//
//  Created by Victor on 2023/11/20.
//

import UIKit

class FriendPageViewController: UIViewController {
    
    @IBOutlet weak var segmentView: CustomSegmentedView!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let withdrawNaviBtn = UIBarButtonItem(image:UIImage(named: "icNavPinkWithdraw") , style: .plain, target: self, action: nil)
        let transNaviBtn = UIBarButtonItem(image:UIImage(named: "icNavPinkTransfer") , style: .plain, target: self, action: nil)
        let scanNaviBtn = UIBarButtonItem(image:UIImage(named: "icNavPinkScan") , style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItems = [withdrawNaviBtn,transNaviBtn]
        self.navigationItem.rightBarButtonItems = [scanNaviBtn]
       
        
        segmentView.delegate = self
        segmentView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "EmptyFriendCell", bundle: nil), forCellReuseIdentifier: "EmptyFriendCell")
        tableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
        tableView.register(UINib(nibName: "FriendInfoCell", bundle: nil), forCellReuseIdentifier: "FriendInfoCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
    }
    



}

extension FriendPageViewController: CustemSegmontedViewDelegate ,CustemSegmontedViewDataSource{
    func didSelect(row: Int) -> Bool {
        return true
    }
    
    func itemNumber() -> Int {
        return 2
    }
    
    func itemTitle(row: Int) -> String {
        let titleArr = ["朋友","聊天"]
        return titleArr[row]
    }
}


extension FriendPageViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendInfoCell", for: indexPath) as! FriendInfoCell
            cell.setUpCellStatus(isTop: true, status: 1)
            return cell
        }
       
    }
    
    
}
