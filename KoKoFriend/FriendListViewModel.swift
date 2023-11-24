//
//  FriendListViewModel.swift
//  KoKoFriend
//
//  Created by Victor on 2023/11/23.
//

import Foundation

final class FriendListViewModel {
    var friendsList:[FriendList]?
    {
        didSet {
            self.reloadViewClosure?()
        }
    }
    var invitedfriendList:[FriendList]? {
        didSet {
            self.reloadViewClosure?()
        }
    }
    var user:[User]?
    var reloadViewClosure: (()->())?
    var fetchDataType:dataType?
    var tempStoreList:[FriendList]?{
        didSet{
            self.reloadViewClosure?()
        }
    }
    init() {
        getUserInfo()
    }
    
    
    func fetchData(){
        switch UserManager.shared.apiType {
        case.noFriend:
            getZeroFriend()
        case .friendButNoInvite:
            combineTwoFriendLsit()
        case.friendAndInvite:
            getFriendListWithInvited()
        }
    }
    
    func searchFriend(text:String) {
        tempStoreList = friendsList
        friendsList = friendsList?.filter({ $0.name.localizedStandardContains(text)  })
    }
    
    func cleanSearchTextField(){
        friendsList = tempStoreList
    }
    
    func getZeroFriend(){
        APIManager.shared.getFriendListWithInvited(urlString: APIManager.shared.friendListZero) { isSuccess, error, response in
            if isSuccess {
                self.friendsList = response?.response
            }else{
                print("Oops")
            }
        }
    }
    
    func getFriendListWithInvited(){
        APIManager.shared.getFriendListWithInvited(urlString: APIManager.shared.friendListWithInvitedURL) { isSuccess, error, response in
            if isSuccess {
                self.invitedfriendList = response?.response.filter({ $0.status == 0 })
                self.friendsList = response?.response.filter({ $0.status != 0 })
            }else{
                print("Oops")
            }
        }
    }
    
    
    func combineTwoFriendLsit(){
        let dispatchGroup = DispatchGroup()
        var responseOne:[FriendList]?
        var responseTwo:[FriendList]?
        dispatchGroup.enter()
        APIManager.shared.getFriendListWithInvited(urlString: APIManager.shared.friendListOneURL) { isSuccess, error, response in
            if isSuccess {
                responseOne = response?.response
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        APIManager.shared.getFriendListWithInvited(urlString: APIManager.shared.friendListTwoURL) { isSuccess, error, response in
            if isSuccess {
                responseTwo = response?.response
                dispatchGroup.leave()
            }else{
                print("Oops")
            }
        }
        
        
        dispatchGroup.notify(queue: .main) {
            self.friendsList = mergeArrays(arr1: responseOne, arr2: responseTwo)
            self.reloadViewClosure?()
        }
        
        
        
        func date(from dateString: String) -> Date? {
            let dateFormatter = DateFormatter()
            if dateString.contains("/") {
                dateFormatter.dateFormat = "yyyy/MM/dd"
            }else {
                dateFormatter.dateFormat = "yyyyMMdd"
            }
            return dateFormatter.date(from: dateString)
        }
        
        func mergeArrays(arr1: [FriendList]?, arr2: [FriendList]?) -> [FriendList]? {
            
            guard let arr1 = arr1, let arr2 = arr2 else {
                return nil
            }
            
            var mergedDictionary: [String: FriendList] = [:]
            
            for friend in arr1 {
                mergedDictionary[friend.fid] = friend
            }
            
            
            for friend in arr2 {
                if let existingFriend = mergedDictionary[friend.fid] {
                    
                    if let existingDate = date(from: existingFriend.updateDate),
                       let currentDate = date(from: friend.updateDate),
                       currentDate > existingDate {
                        mergedDictionary[friend.fid] = friend
                    }
                } else {
                    
                    mergedDictionary[friend.fid] = friend
                }
            }
            
            let mergedArray = Array(mergedDictionary.values)
            
            return mergedArray
        }
    }
    
    func getUserInfo()
    {
        APIManager.shared.getUserInfo { isSuccess, error, response in
            if isSuccess {
                self.user = response?.response
            }else{
                print("Oops")
            }
        }
    }
    
}

class UserManager {
    static let shared = UserManager()
    var apiType:dataType = .noFriend
}
