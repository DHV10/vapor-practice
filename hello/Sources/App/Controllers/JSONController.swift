//
//  File.swift
//  
//
//  Created by Việt Dương Hoàng on 2/8/24.
//

import Foundation
import Vapor

struct User: Content {
    let name: String
    let age: Int
    let address: Address?
}

struct Address: Content {
    let city: String
    let zipCode: String
}

struct AddUserRequest: Content {
    let user: User
}

struct AddUserResponse: Content {
    let status: HTTPStatus
    let listUser: [User]
}

struct JSONController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let api = routes.grouped("api")
        api.get("getUser", use: getUser)
        api.post("addUser", use: addUser)
        api.post("users",use: create)
    }
    
    func getUser(req: Request) throws -> [User] {
        let user = User(name: "DHV10", age: 20, address: Address(city: "Hanoi", zipCode: "123123"))
        let user2 = User(name: "DHV11", age: 21, address: nil)
        let response = [user, user2]
        
        return response
    }
    
    func addUser(req: Request) throws -> AddUserResponse {
        let response = try req.content.decode(AddUserRequest.self)
        return AddUserResponse(status: .ok, listUser: [response.user])
    }
    
    func create(req: Request) throws -> HTTPStatus {
        
        let user = try req.content.decode(User.self)
        print(user)
        return HTTPStatus.ok
        
    }
}
