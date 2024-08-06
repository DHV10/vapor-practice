//
//  File.swift
//  
//
//  Created by Việt Dương Hoàng on 2/8/24.
//

import Foundation
import Vapor

struct DemoController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        routes.get("DHV10") {req async -> String in
            "Hello, world! DHV10"
        }
        
        routes.get("DHV10", "soccer") { req async -> String in
            "Hello, world! DHV10 soccer"
        }
        
        routes.get("DHV10", ":sport") { req -> String in
            guard let sport = req.parameters.get("sport") else {
                throw Abort(.badRequest)
            }
            return "DHV10x\(sport)"
        }
        
        routes.get("DHV10", ":sport", ":year") { req -> String in
            guard let sport = req.parameters.get("sport"),
                  let year = req.parameters.get("year") else {
                throw Abort(.badRequest)
            }
            return "DHV10x\(sport)x\(year)"
        }
        
        routes.get("DHV11", "*", "DHV120") { req async -> String in
            "Hello, world! DHV10 soccer xxxxx"
        }
        
        routes.get("DHV11", "**") { req async -> String in
            "Hello, world! DHV10 soccer xx1xxx"
        }
        
        routes.get("search") { req -> String in
            guard let key = req.query["key"] as String?,
                  let page = req.query["page"] as Int? else {
                throw Abort(.badGateway)
            }
            return "Search with key = \(key) in page = \(page) "
        }
        
        let DHV99 = routes.grouped("DHV99")
        DHV99.get(":name") { req -> String in
            guard let name = req.parameters.get("name") else {
                throw Abort(.conflict)
            }
            return "DHV99 = \(name)"
        }
    }
}
