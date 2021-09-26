//
//  Downloader.swift
//  DownloadImage
//
//  Created by Emanuel Flores Martínez on 26/09/21.
//

import UIKit

class Downloader {
    class func downloadImageWithURl(_ url: String) -> UIImage! {
        if let data = try? Data(contentsOf: URL(string: url)!) {
            return UIImage(data: data)!
        }
        return nil
    }
    
    class func downloadMetadataWithURl(_ url: String) -> ImageMetadata! {
        if let data = try? Data(contentsOf: URL(string: url)!) {
            let metadata = try? JSONDecoder().decode(ImageMetadata.self, from: data)
            return metadata
        }
        return nil
    }
}
