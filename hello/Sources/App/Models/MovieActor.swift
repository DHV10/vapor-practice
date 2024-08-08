//
//  File.swift
//  
//
//  Created by Việt Dương Hoàng on 8/8/24.
//

import Foundation
import Vapor
import Fluent
import FluentPostgresDriver

final class MovieActor: Model, Content {
    
    static let schema: String = "movie_actors"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "movie_id")
    var movie: Movie
    
    @Parent(key: "actor_id")
    var actor: Actor
    
    init() {}
    
    init(id: UUID? = nil, movieId: UUID, actorId: UUID) {
        self.id = id
        self.$movie.id = movieId
        self.$actor.id = actorId
    }
}
