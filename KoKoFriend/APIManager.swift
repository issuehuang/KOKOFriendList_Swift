//
//  APIManager.swift
//  KoKoFriend
//
//  Created by Victor on 2023/11/23.
//

import Foundation
class APIManager {
    static let shared = APIManager()
    let userInfoURL = "https://dimanyen.github.io/man.json"
    let friendListWithInvitedURL = "https://dimanyen.github.io/friend3.json"
    typealias Complate = (Data?, Error?) -> Void

    func getUserInfo(completion:@escaping(_ isSuccess:Bool,_ error:Error?,UserDataResponse?)->()){
        
        requestWithHeader(urlString: userInfoURL, parameters: [:]) { (data, error) in
            guard let data = data else {
                completion(false,error,nil)
                return
            }
            DispatchQueue.main.async {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(UserDataResponse.self, from: data)
                    completion(true,nil,result)
                }catch let error {
                    completion(true,error,nil)
                }
            }
        }
    }
    
    func getFriendListWithInvited(completion:@escaping(_ isSuccess:Bool,_ error:Error?,FriendListResponse?)->()){
        requestWithHeader(urlString: friendListWithInvitedURL, parameters: [:]) { (data, error) in
            guard let data = data else {
                completion(false,error,nil)
                return
            }
            DispatchQueue.main.async {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(FriendListResponse.self, from: data)
                    completion(true,nil,result)
                }catch let error {
                    completion(true,error,nil)
                }
            }
        }
    }
    
    private func requestWithHeader(urlString: String, parameters: [String: String], completion: @escaping (Complate)){
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        for (key, value) in parameters{
            request.addValue(value, forHTTPHeaderField: key)
        }
        fetchedDataByDataTask(from: request, completion: completion)
        
    }
    
    private func fetchedDataByDataTask(from request: URLRequest, completion: @escaping (Complate)){
           
           let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
               
               let status = (response as? HTTPURLResponse)?.statusCode ?? 0
               print("response status: \(status)")
               
               if error != nil{
                   completion(data,error)
                   print(error as Any)
               }else{
                   guard let data = data else{return}
                   DispatchQueue.main.async {
                       completion(data, error)
                     
                   }
               }
           }
           task.resume()
       }
}
