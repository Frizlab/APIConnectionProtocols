import Foundation

import TaskQueue



public extension Connector {
	
	/** True if `currentScope` is not `nil`. */
	var isConnected: Bool {
		return currentScope != nil
	}
	
}


public extension Connector where Self : HasTaskQueue {
	
	/**
	 Connects the given scope in an ``HasTaskQueue.executeOnTaskQueue(_:)`` block.
	 
	 `executeOnTaskQueue` will add the given block to a queue and execute all blocks in sequence,
	 which prevents concurrent connection operations.
	 
	 - Returns: The new scopes after the connection. */
	@discardableResult
	func connect(scope: Scope, auth: Authentication) async throws -> Scope {
		return try await executeOnTaskQueue{ () -> Scope in
			return try await self.unqueuedConnect(scope: scope, auth: auth)
			/* This must be true, but cannot be verified because Scope is not Equatable. */
//			assert(ret == self.currentScope)
		}
	}
	
	/**
	 Disconnects the connector in an ``HasTaskQueue.executeOnTaskQueue(_:)`` block.
	 
	 `executeOnTaskQueue` will add the given block to a queue and execute all blocks in sequence,
	 which prevents concurrent connection operations. */
	func disconnect() async throws {
		try await executeOnTaskQueue{
			try await self.unqueuedDisconnect()
			assert(self.currentScope == nil)
		}
	}
	
}
