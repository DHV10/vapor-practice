//
//  File.swift
//  
//
//  Created by Việt Dương Hoàng on 6/8/24.
//

import Foundation
import Vapor

struct MovieController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        routes.post("movies") { req -> EventLoopFuture<Movie> in
            let movie = try req.content.decode(Movie.self)
            return movie.create(on: req.db).map { movie }
        }
        
        routes.get("movies") { req in
            Movie.query(on: req.db).with(\.$reviews).all()
        }
        
        routes.get("movies", ":movieId") { req -> EventLoopFuture<Movie> in
            Movie.find(req.parameters.get("movieId"), on: req.db)
                .unwrap(or: Abort(.notFound))
        }
        
        routes.put("movies") { req -> EventLoopFuture<HTTPStatus> in
            let movie = try req.content.decode(Movie.self)
            return Movie.find(movie.id, on: req.db)
                .unwrap(or: Abort(.notFound))
                .flatMap {
                    $0.title = movie.title
                    return $0.update(on: req.db).transform(to: .ok)
                }
        }
        
        routes.delete("movies", ":movieId") { req -> EventLoopFuture<HTTPStatus> in
            Movie.find(req.parameters.get("movieId"), on: req.db)
                .unwrap(or: Abort(.notFound))
                .flatMap {
                    $0.delete(on: req.db)
                }.transform(to: .ok)
        }
    }
}
