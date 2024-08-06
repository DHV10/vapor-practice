//
//  File.swift
//  
//
//  Created by Việt Dương Hoàng on 1/8/24.
//

import Foundation
import Vapor

struct UserController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let users = routes.grouped("users")
        
        users.get(use: index)
        users.post(use: create)
        users.group(":userId") { user in
            user.get(use: show)
        }
    }
    
    func index(req: Request) throws -> String {
        return "ABC"
    }
    
    func create(req: Request) throws -> String {
        return "ABCD"
    }
    
    func show(req: Request) throws -> String {
        guard let userId = req.parameters.get("userId") as String? else {
            throw Abort(.badRequest)
        }
        return "ABCDE---\(userId)"
    }
}

