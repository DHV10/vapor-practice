//
//  File.swift
//  
//
//  Created by Việt Dương Hoàng on 6/8/24.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateMovie: Migration {
    
    func prepare(on database: any Database) -> EventLoopFuture<Void> {
        database.schema("movies")
            .id()
            .field("title", .string)
            .create()
    }
    
    func revert(on database: any Database) -> EventLoopFuture<Void> {
        database.schema("movies").delete()
    }
}
