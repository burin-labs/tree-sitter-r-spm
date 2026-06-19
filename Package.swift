// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "TreeSitterR",
    products: [.library(name: "TreeSitterR", targets: ["TreeSitterR"])],
    targets: [
        .target(
            name: "TreeSitterR",
            path: "Sources/TreeSitterR",
            sources: ["src/parser.c", "src/scanner.c"],
            publicHeadersPath: "include",
            cSettings: [.headerSearchPath("src")]
        )
    ]
)
