import Foundation

import TaskQueue



public extension Authenticator where Self : HasTaskQueue {
	
	func authenticate(request: Request) async throws -> Request {
		return try await executeOnTaskQueue{ () -> Request in
			return try await self.unqueuedAuthenticate(request: request)
		}
	}
	
}
