//
//  FriendListResponse.swift
//  KoKoFriend
//
//  Created by Victor on 2023/11/19.
//

import Foundation

struct FriendListResponse:Codable {
    let response:[FriendList]
}

struct FriendList:Codable{
    let name:String
    let status: Int
    let isTop: String
    let fid: String
    let updateDate: String
}
