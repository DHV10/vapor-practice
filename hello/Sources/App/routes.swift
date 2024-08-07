import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }
    
    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    try app.register(collection: DemoController())
    
    try app.register(collection: UserController())
    
    try app.register(collection: JSONController())
    
    try app.register(collection: MovieController())
    
    try app.register(collection: ReviewController())
}
