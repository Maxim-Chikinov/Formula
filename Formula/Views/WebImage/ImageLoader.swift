//
//  ImageLoader.swift
//  Formula
//
//  Created by Chikinov Maxim on 25.10.2024.
//

import Foundation
import SwiftUI

final class ImageLoader: Sendable {
    private let imageUrl: URL
    
    init(imageUrl: URL) {
        self.imageUrl = imageUrl
    }
    
    var image: UIImage {
        get async throws {
            let (data, _) = try await URLSession.shared.data(from: imageUrl)
            guard let image = UIImage(data: data) else {
                throw ImageLoaderError.incorrectImageData
            }
            return image
        }
    }
}
