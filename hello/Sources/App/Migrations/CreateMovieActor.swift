//
//  File.swift
//  
//
//  Created by Việt Dương Hoàng on 8/8/24.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateMovieActor: Migration {
    
    func prepare(on database: any Database) -> EventLoopFuture<Void> {
        database.schema("movie_actors")
            .id()
            .field("movie_id", .uuid, .references("movies", "id"))
            .field("actor_id", .uuid, .references("actors", "id"))
            .create()
    }
    
    func revert(on database: any Database) -> EventLoopFuture<Void> {
        database.schema("movie_actors").delete()
    }
}
