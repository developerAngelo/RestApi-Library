//
//  ViewController.swift
//  RestApi-Library
//
//  Created by Ruthlyn Huet on 5/4/21.
//

import UIKit

class ViewController: UIViewController {

    let rest = RestManager()

    override func viewDidLoad() {
        super.viewDidLoad()
//        getUsersList()
        
//        getNonExistingUser()
        
//        createUser()
        
        getSingleUser()
        
    }
    
    func getUsersList() {

        guard let url = URL(string: "https://reqres.in/api/users") else { return }
        
        rest.urlQueryParameter.add(value: "2", forkey: "page")
        
        rest.makeRequest(toURL: url, with: .get) { (results) in
            if let data = results.data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let userData = try? decoder.decode(UserData.self, from: data) else { return }
                print(userData.description)
            }
            
            print("\n\nResponse HTTP Headers:\n")
            
            if let response = results.response{
                for (key, value) in response.headers.allValues() {
                    print(key, value)
                }
            }
            
        }
    }
    
    func getNonExistingUser(){
        guard let url = URL(string: "https://reqres.in/api/users/100") else {
            return
        }
        
        rest.makeRequest(toURL: url, with: .get) { (result) in
            if let response = result.response{
                if response.httpStatusCode != 200{
                    print("\n Request failed with HTTP status code", response.httpStatusCode)
                }
            }
        }
        
    }
    
    func createUser(){
        guard let url = URL(string: "https://reqres.in/api/users") else {
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        rest.httpBodyParameters.add(value: "Angelo", forkey: "name")
        rest.httpBodyParameters.add(value: "IOS Developer", forkey: "job")
        
        rest.makeRequest(toURL: url, with: .post) { (results) in
            guard let response = results.response else{return}
            
            if response.httpStatusCode == 201{
                guard let data = results.data else {
                    return
                }
                let decoder = JSONDecoder()
                guard let jobUser = try? decoder.decode(JobUsers.self, from: data) else {
                    return
                }
                print(jobUser.description)
            }
        }
        
    }
    
    
    func getSingleUser(){
        guard let url = URL(string: "https://reqres.in/api/users/1") else { return }

        
        rest.makeRequest(toURL: url, with: .get) { (results) in
            if let data = results.data{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let singleUserData = try? decoder.decode(SingleUserData.self, from: data),
                let user = singleUserData.data,
                let avatar = user.avatar,
                let url = URL(string: avatar) else{return}
                
                self.rest.getData(fromURL: url) { (avatarData) in
                    guard let avatarData = avatarData else { return }
                    let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
                    let saveURl = cacheDirectory.appendingPathComponent("avatar.jpg")
                    try? avatarData.write(to: saveURl)
                    print("\n Saved avatar URL: \n\(saveURl)\n")
                }
                
            }
        }
    }


}

