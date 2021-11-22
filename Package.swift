// swift-tools-version:5.5
import PackageDescription


let package = Package(
	name: "APIConnectionProtocols",
	platforms: [.macOS(.v12), .iOS(.v15), .tvOS(.v15), .watchOS(.v8)],
	products: [.library(name: "APIConnectionProtocols", targets: ["APIConnectionProtocols"])],
	dependencies: [
		.package(url: "https://github.com/Frizlab/swift-task-queue.git", from: "1.0.0")
	],
	targets: [
		.target(name: "APIConnectionProtocols", dependencies: [
			.product(name: "TaskQueue", package: "swift-task-queue")
		])
	]
)
