//
//  UserDataStucture.swift
//  RestApi-Library
//
//  Created by Ruthlyn Huet on 5/5/21.
//

import Foundation


var defString = String(stringLiteral: "")
var defInt = -1

struct UserData: Codable, CustomStringConvertible {
    var page: Int?
    var perPage: Int?
    var total: Int?
    var totalPages: Int?
    var data: [User]?
    
    var description: String {
        var desc = """
        page = \(page ?? defInt)
        records per page = \(perPage ?? defInt)
        total records = \(total ?? defInt)
        total pages = \(totalPages ?? defInt)
        Users:
        
        """
        if let users = data {
            for user in users {
                desc += user.description
            }
        }
        
        return desc
    }
}   

struct User: Codable, CustomStringConvertible {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var avatar: String?

    var description: String {
        return """
        ------------
        id = \(id ?? defInt)
        firstName = \(firstName ?? defString)
        lastName = \(lastName ?? defString)
        avatar = \(avatar ?? defString)
        ------------
        """
    }
}

struct JobUsers: Codable, CustomStringConvertible {
    var id: String?
    var name: String?
    var job: String?
    var createdAt: String?
    
    var description: String{
        return """

            id = \(id ?? defString)
            name = \(name ?? defString)
            job = \(job ?? defString)
            createAt = \(createdAt ?? defString)

            """
    }
}

struct SingleUserData: Codable{
    var data: User?
}
