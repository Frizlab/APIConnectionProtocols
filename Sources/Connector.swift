import Foundation



public protocol Connector : Actor {
	
	/** The authentication required to connect. E.g. username/password, a token from another connector, etc. */
	associatedtype Authentication
	
	var isConnected: Bool {get}
	
	/**
	 The connection method.
	 Try and grant the given scope using the given auth, then sets ``currentScope`` accordingly and return it.
	 
	 Some APIs may not grant all the scope provided, but still succeed the authentication.
	 A connector implementations might fail or not depending on business logic if fewer scope than asked are granted by the API.
	 
	 Clients should thus verify the acquired scope is ok for them by checking the returned value.
	 
	 If the current scope were already set (connector is connected), business logic should dictate how the connector will behave.
	 For instance the connector can decide to add the scopes that are not present in the current scope,
	 or disconnect completely and re-connect with the new scopes,
	 etc.
	 In general calling the connect method on a connected connector should be avoided.
	 
	 - Important:
	 This method does not care if there is already a connection in progress.
	 If the connector also conforms to ``HasTaskQueue``, you can use ``executeOnTaskQueue`` to avoid concurrent connections. */
	func onQueue_connect(_ auth: Authentication) async throws
	/**
	 The disconnection method.
	 Try and revoke the current scope, then sets ``currentScope`` to `nil` (on success).
	 
	 If the connector was already disconnected, the function should succeed immediately.
	 In general calling the disconnect method on a disconnected connector should be avoided.
	 
	 - Important:
	 This method does not care if there is already a connection in progress.
	 If the connector also conforms to ``HasTaskQueue``, you can use ``executeOnTaskQueue`` to avoid concurrent connections. */
	func onQueue_disconnect() async throws
	
}
