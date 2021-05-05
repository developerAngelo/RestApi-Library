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
        print("Starting fetching...")
        getUsersList()
        
    }
    
    func getUsersList() {

        guard let url = URL(string: "https://reqres.in/api/users") else { return }

        rest.makeRequest(toURL: url, with: .get) { (results) in
            if let data = results.data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let userData = try? decoder.decode(UserData.self, from: data) else { return }
                print(userData.description)
            }
        }
    }


}

