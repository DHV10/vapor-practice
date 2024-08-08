//
//  File.swift
//  
//
//  Created by Việt Dương Hoàng on 8/8/24.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateActor: Migration {
    
    func prepare(on database: any Database) -> EventLoopFuture<Void> {
        database.schema("actors")
            .id()
            .field("name", .string)
            .create()
    }
    
    func revert(on database: any Database) -> EventLoopFuture<Void> {
        database.schema("actors").delete()
    }
}
