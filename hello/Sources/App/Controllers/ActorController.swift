//
//  File.swift
//  
//
//  Created by Việt Dương Hoàng on 8/8/24.
//

import Foundation
import Vapor

struct ActorController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        routes.post("actors") { req -> EventLoopFuture<Actor> in
            let review = try req.content.decode(Actor.self)
            return review.create(on: req.db).map { review }
        }
        
        routes.post("movie", ":movieId", "actor", ":actorId") { req -> EventLoopFuture<HTTPStatus> in
            let movie = Movie.find(req.parameters.get("movieId"), on: req.db)
                .unwrap(or: Abort(.notFound))
            let actor = Actor.find(req.parameters.get("actorId"), on: req.db)
                .unwrap(or: Abort(.notFound))
            
            return movie.and(actor).flatMap { (movie, actor) in
                movie.$actors.attach(actor, on: req.db)
            }.transform(to: .ok)
        }
        
        routes.get("actors") { req in
            Actor.query(on: req.db).with(\.$movies).all()
        }
    }
}
