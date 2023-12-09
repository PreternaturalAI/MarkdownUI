//
// Copyright (c) Vatsal Manot
//

import SwiftUIZ

public struct Markdown: View {
    @Environment(\._markdownUnsafeFlags) var _markdownUnsafeFlags
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.theme.text) private var text
    
    private let content: MarkdownContent
    private let baseURL: URL?
    private let imageBaseURL: URL?
    
    private var blocks: [BlockNode] {
        self.content.blocks.filterImagesMatching(colorScheme: self.colorScheme)
    }
    
    public var body: some View {
        TextStyleAttributesReader { attributes in
            BlockSequence(self.blocks)
                .foregroundColor(attributes.foregroundColor)
                .background(attributes.backgroundColor)
                .modifier(ScaledFontSizeModifier(attributes.fontProperties?.size))
        }
        .textStyle(self.text)
        .environment(\.baseURL, self.baseURL)
        .environment(\.imageBaseURL, self.imageBaseURL)
    }
}

extension Markdown {
    public init(
        _ content: MarkdownContent,
        baseURL: URL? = nil,
        imageBaseURL: URL? = nil
    ) {
        self.content = content
        self.baseURL = baseURL
        self.imageBaseURL = imageBaseURL ?? baseURL
    }

    public init(
        _ markdown: String,
        baseURL: URL? = nil,
        imageBaseURL: URL? = nil
    ) {
        self.init(MarkdownContent(markdown), baseURL: baseURL, imageBaseURL: imageBaseURL)
    }
}

// MARK: - Auxiliary

public enum _MarkdownUnsafeFlag {
    case nonLazyRendering
}

extension EnvironmentValues {
    @EnvironmentValue
    var _markdownUnsafeFlags: Set<_MarkdownUnsafeFlag> = []
}

private struct ScaledFontSizeModifier: ViewModifier {
    @ScaledMetric private var size: CGFloat
    
    init(_ size: CGFloat?) {
        self._size = ScaledMetric(
            wrappedValue: size ?? FontProperties.defaultSize,
            relativeTo: .body
        )
    }
    
    func body(content: Content) -> some View {
        content.markdownTextStyle {
            FontSize(self.size)
        }
    }
}
