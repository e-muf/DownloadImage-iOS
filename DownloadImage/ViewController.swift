//
//  ViewController.swift
//  DownloadImage
//
//  Created by Emanuel Flores Martínez on 26/09/21.
//

import UIKit

enum ImageDownloadError: Error {
    case badImage
}

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var firstAppearanceLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadImageAndMetadata(imageNumber: 1) { result in
            switch result {
            case .success(let detailedImage):
                DispatchQueue.main.async {
                    self.imageView.image = detailedImage.image
                    self.nameLabel.text = "Nombre: \(detailedImage.metadata.name)"
                    self.firstAppearanceLabel.text = "Primer Aparición: \(detailedImage.metadata.firstAppearance)"
                    self.yearLabel.text = "Año: \(detailedImage.metadata.year)"
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func downloadImageAndMetadata(
        imageNumber: Int,
        completionHandler: @escaping(Result<DetailedImage, Error>) -> Void
    ) {
        let imageUrl = "https://www.andyibanez.com/fairesepages.github.io/tutorials/async-await/part1/\(imageNumber).png"
        let metadataUrl = "https://www.andyibanez.com/fairesepages.github.io/tutorials/async-await/part1/\(imageNumber).json"
        let queue = OperationQueue()
        var image: UIImage?
        var metadata: ImageMetadata?
        let operation = BlockOperation {
            image = Downloader.downloadImageWithURl(imageUrl)
            metadata = Downloader.downloadMetadataWithURl(metadataUrl)
        }
    
        operation.completionBlock = {
            guard let image = image, let metadata = metadata else {
                return
            }
            completionHandler(.success(DetailedImage(image: image, metadata: metadata)))
        }
        
        queue.addOperation(operation)
    }
}

