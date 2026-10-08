// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "GlassCard",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "GlassCard", targets: ["GlassCard"]),
        .executable(name: "GlassCardDemo", targets: ["GlassCardDemo"])
    ],
    targets: [
        .target(name: "GlassCard"),
        .executableTarget(name: "GlassCardDemo", dependencies: ["GlassCard"]),
        .testTarget(name: "GlassCardTests", dependencies: ["GlassCard"])
    ]
)
