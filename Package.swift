// swift-tools-version:5.5
import PackageDescription


let package = Package(
	name: "APIConnectionProtocols",
	platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)],
	products: [.library(name: "APIConnectionProtocols", targets: ["APIConnectionProtocols"])],
	dependencies: [
		.package(url: "https://github.com/Frizlab/swift-task-queue.git", from: "1.1.0")
	],
	targets: [
		.target(name: "APIConnectionProtocols", dependencies: [
			.product(name: "TaskQueue", package: "swift-task-queue")
		], path: "Sources")
	]
)
