//
//  File.swift
//  
//
//  Created by Việt Dương Hoàng on 7/8/24.
//

import Foundation
import Vapor

struct ReviewController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        routes.post("reviews") { req -> EventLoopFuture<Review> in
            let review = try req.content.decode(Review.self)
            return review.create(on: req.db).map { review }
        }
    }
}
