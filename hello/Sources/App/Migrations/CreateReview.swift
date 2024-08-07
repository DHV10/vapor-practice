//
//  File.swift
//  
//
//  Created by Việt Dương Hoàng on 7/8/24.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateReview: Migration {
    
    func prepare(on database: any Database) -> EventLoopFuture<Void> {
        database.schema("reviews")
            .id()
            .field("title", .string)
            .field("body", .string)
            .field("movie_id", .uuid, .references("movies", "id"))
            .create()
    }
    
    func revert(on database: any Database) -> EventLoopFuture<Void> {
        database.schema("reviews").delete()
    }
}

