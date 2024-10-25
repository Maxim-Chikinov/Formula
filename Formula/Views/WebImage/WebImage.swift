//
//  WebImage.swift
//  Formula
//
//  Created by Chikinov Maxim on 25.10.2024.
//

import Foundation
import SwiftUI

struct WebImage: View {
    
    let url: URL?
    
    @State
    private var uiImage: UIImage?
    
    var body: some View {
        imageView()
            .task { @MainActor in
                do {
                    guard let url else { return }
                    let imageLoader = ImageLoader(imageUrl: url)
                    uiImage = try await imageLoader.image
                } catch {}
            }
    }
    
    @ViewBuilder
    func imageView() -> some View {
        if let uiImage {
            Image(uiImage: uiImage)
                .resizable()
                .clipped()
                .transition(.opacity)
        } else {
            ZStack {
                Rectangle()
                    .fill(Color.black.opacity(0.1))
                ProgressView()
            }
        }
    }
}

#Preview {
    let url =
"""
https://humanitarianpartnershipconference.files.wordpress.com/2016/09/nicolette-recipe-book-step-1.jpg
"""
    return WebImage(url: URL(string: url)!)
        .scaledToFit()
}
