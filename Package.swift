// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "MarkdownUI",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .tvOS(.v15),
        .watchOS(.v8),
    ],
    products: [
        .library(
            name: "MarkdownUI",
            targets: [
                "MarkdownUI"
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/kean/Nuke.git", from: "12.1.6"),
        .package(url: "https://github.com/SwiftUIX/SwiftUIX.git", branch: "master"),
        .package(url: "https://github.com/vmanot/Swallow.git", branch: "master")
    ],
    targets: [
        .target(name: "cmark-gfm"),
        .target(
            name: "MarkdownUI",
            dependencies: [
                "cmark-gfm",
                .product(name: "NukeUI", package: "Nuke"),
                "Swallow",
                "SwiftUIX"
            ]
        )
    ]
)
