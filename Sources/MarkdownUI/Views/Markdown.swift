import SwiftUIX

public struct Markdown: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.theme.text) private var text
    
    private let content: MarkdownContent
    private let baseURL: URL?
    private let imageBaseURL: URL?
    
    private var blocks: [BlockNode] {
        self.content.blocks.filterImagesMatching(colorScheme: self.colorScheme)
    }

    /// Creates a Markdown view from a Markdown content value.
    /// - Parameters:
    ///   - content: The Markdown content value.
    ///   - baseURL: The base URL to use when resolving Markdown URLs. If this value is `nil`, the initializer will consider all
    ///              URLs absolute. The default is `nil`.
    ///   - imageBaseURL: The base URL to use when resolving Markdown image URLs. If this value is `nil`, the initializer will
    ///                   determine image URLs using the `baseURL` parameter. The default is `nil`.
    public init(
        _ content: MarkdownContent,
        baseURL: URL? = nil,
        imageBaseURL: URL? = nil
    ) {
        self.content = content
        self.baseURL = baseURL
        self.imageBaseURL = imageBaseURL ?? baseURL
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
    /// Creates a Markdown view from a Markdown-formatted string.
    /// - Parameters:
    ///   - markdown: The string that contains the Markdown formatting.
    ///   - baseURL: The base URL to use when resolving Markdown URLs. If this value is `nil`, the initializer will consider all
    ///              URLs absolute. The default is `nil`.
    ///   - imageBaseURL: The base URL to use when resolving Markdown image URLs. If this value is `nil`, the initializer will
    ///                   determine image URLs using the `baseURL` parameter. The default is `nil`.
    public init(
        _ markdown: String,
        baseURL: URL? = nil,
        imageBaseURL: URL? = nil
    ) {
        self.init(MarkdownContent(markdown), baseURL: baseURL, imageBaseURL: imageBaseURL)
    }
}

private struct ScaledFontSizeModifier: ViewModifier {
    @ScaledMetric private var size: CGFloat
    
    init(_ size: CGFloat?) {
        self._size = ScaledMetric(wrappedValue: size ?? FontProperties.defaultSize, relativeTo: .body)
    }
    
    func body(content: Content) -> some View {
        content.markdownTextStyle {
            FontSize(self.size)
        }
    }
}
