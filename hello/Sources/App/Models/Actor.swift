//
//  File.swift
//  
//
//  Created by Việt Dương Hoàng on 8/8/24.
//

import Foundation
import Fluent
import Vapor

final class Actor: Model, Content {
    
    static let schema = "actors"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Siblings(through: MovieActor.self, from: \.$actor, to: \.$movie)
    var movies: [Movie]
    
    init() {}
    
    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
