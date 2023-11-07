//
// Copyright (c) Vatsal Manot
//

import NukeUI
import SwiftUI

struct DefaultImageView: View {
    let url: URL?
    let urlSession: URLSession
    
    var body: some View {
        LazyImage(url: url) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}
