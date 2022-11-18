import Foundation

import TaskQueue



public extension Connector where Self : HasTaskQueue, Authentication : Sendable {
	
	/**
	 Connects the given scope in an ``HasTaskQueue.executeOnTaskQueue(_:)`` block.
	 
	 `executeOnTaskQueue` will add the given block to a queue and execute all blocks in sequence,
	 which prevents concurrent connection operations.
	 
	 - Returns: The new scopes after the connection. */
	func connect(_ auth: Authentication) async throws {
		try await executeOnTaskQueue{ try await self.unqueuedConnect(auth) }
	}
	
	/**
	 Disconnects the connector in an ``HasTaskQueue.executeOnTaskQueue(_:)`` block.
	 
	 `executeOnTaskQueue` will add the given block to a queue and execute all blocks in sequence,
	 which prevents concurrent connection operations. */
	func disconnect() async throws {
		try await executeOnTaskQueue{ try await self.unqueuedDisconnect() }
	}
	
}


public extension Connector where Self : HasTaskQueue, Authentication == Void {
	
	func connect() async throws {
		try await connect(())
	}
	
}
