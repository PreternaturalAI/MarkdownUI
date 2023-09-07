This is a performance fork of @gonzalezreal's [MarkdownUI](https://github.com/gonzalezreal/swift-markdown-ui).

- `BlockSequence` no longer uses a `VStack`, allowing for lazy loading of large Markdown content via `LazyVStack { ... }`.
- Integration of SwiftUIX for advanced view caching and Nuke for efficient remote image loading.
- The result builder DSL has been removed.
