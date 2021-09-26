//
//  DetailedImage.swift
//  DownloadImage
//
//  Created by Emanuel Flores Martínez on 26/09/21.
//

import UIKit

struct DetailedImage {
    var image: UIImage
    var metadata: ImageMetadata
}

struct ImageMetadata: Codable {
    let name: String
    let firstAppearance: String
    let year: Int
}
