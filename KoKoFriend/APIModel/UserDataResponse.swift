//
//  UserDataResponse.swift
//  KoKoFriend
//
//  Created by Victor on 2023/11/19.
//

import Foundation

struct UserDataResponse:Codable {
    let response:[User]
}

struct User:Codable{
    let name:String
    let kokoid:String
}
