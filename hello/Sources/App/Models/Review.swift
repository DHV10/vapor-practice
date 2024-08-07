//
//  File.swift
//  
//
//  Created by Việt Dương Hoàng on 7/8/24.
//

import Foundation
import Vapor
import Fluent
import FluentPostgresDriver

final class Review: Model, Content {
    
    static let schema: String = "reviews"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "body")
    var body: String
    
    @Parent(key: "movie_id")
    var movie: Movie
    
    init() {}
    
    init(id: UUID? = nil, title: String, body: String, movieId: UUID) {
        self.id = id
        self.title = title
        self.body = body
        self.$movie.id = movieId
    }
}
