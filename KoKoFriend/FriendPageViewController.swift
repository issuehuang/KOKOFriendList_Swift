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
    @IBOutlet weak var inviteListTableView: UITableView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var kokoIDBtn: UIButton!
    @IBOutlet weak var invitedFriendViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerViewConstraint: NSLayoutConstraint!
    private var invitedfriendList:[FriendList]?
    private var friendsList:[FriendList]?
    private var viewModel = FriendListViewModel()
    private var searchText:String = ""
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
        
        inviteListTableView.delegate = self
        inviteListTableView.dataSource = self
        inviteListTableView.register(UINib(nibName: "InvitedCell", bundle: nil), forCellReuseIdentifier: "InvitedCell")
        inviteListTableView.separatorStyle = .none
        
        
       
     
        viewModel.reloadViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.inviteListTableView.reloadData()
            }
        }
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.userNameLabel.text = viewModel.user?.first?.name
        let kokoid = viewModel.user?.first?.kokoid ?? ""
        self.kokoIDBtn.setTitle("KOKO ID : \(kokoid)", for: .normal)
        viewModel.fetchData()
        if UserManager.shared.apiType == .friendAndInvite {
            invitedFriendViewHeightConstraint.constant = 175
            headerViewConstraint.constant = 268
        }else {
            invitedFriendViewHeightConstraint.constant = 0
            headerViewConstraint.constant = 268 - 175
        }
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
        switch tableView {
        case inviteListTableView:
            return viewModel.invitedfriendList?.count ?? 0
        case tableView:
            return ((viewModel.friendsList?.count ?? 0) + 1)
        default:
            return 2
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == inviteListTableView {
            return 70
        }else{
            if viewModel.friendsList?.count != 0 {
                return 60
            }else{
                return UITableView.automaticDimension
            }
                
           
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case inviteListTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InvitedCell", for: indexPath) as! InvitedCell
            cell.nameLabel.text = viewModel.invitedfriendList?[indexPath.row].name
            return cell
        case tableView:
            if indexPath.row == 0 {
                if viewModel.friendsList?.count == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyFriendCell", for: indexPath) as! EmptyFriendCell
                    return cell
                }else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
                    cell.searchBtn.addTarget(self, action: #selector(tapSearchBtn), for: .touchUpInside)
                    cell.textfield.delegate = self
                    return cell
                }
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FriendInfoCell", for: indexPath) as! FriendInfoCell
                guard let friend = viewModel.friendsList?[indexPath.row - 1] else { return  UITableViewCell()}
                cell.setUpCellStatus(isTop: friend.isTop, status: friend.status)
                cell.nameLabel.text = friend.name
                return cell
            }
        default:
            return UITableViewCell()
        }
        
        
    }
    
    @objc func tapSearchBtn(){
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SearchCell
        viewModel.searchFriend(text:cell?.textfield.text ?? "")
    }
}
extension FriendPageViewController:UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        viewModel.cleanSearchTextField()
        return true
    }
}
