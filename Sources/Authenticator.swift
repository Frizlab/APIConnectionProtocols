import Foundation



public protocol Authenticator : Actor {
	
	associatedtype Request
	
	func onQueue_authenticate(request: Request) async throws -> Request
	
}
