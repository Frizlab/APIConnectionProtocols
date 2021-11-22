import Foundation



public protocol Authenticator : Actor {
	
	associatedtype Request
	
	func unqueuedAuthenticate(request: Request) async throws -> Request
	
}
