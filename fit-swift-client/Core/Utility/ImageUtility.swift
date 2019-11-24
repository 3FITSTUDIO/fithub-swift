//
//  ImageUtility.swift
//  fit-swift-client
//
//  Created by admin on 24/11/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit

struct ImageUtility {
    
    static func resizeImage(fromURL url: URL, for size: CGSize) -> UIImage? {
        guard let image = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        return resizeImage(image: image, toSize: size)
    }
    
    static func resizeImage(image: UIImage?, toSize: CGSize) -> UIImage {
        if let image = image {
            let renderer = UIGraphicsImageRenderer(size: toSize)
            return renderer.image { (context) in
                image.draw(in: CGRect(origin: .zero, size: toSize))
            }
        }
        else {
            return UIImage()
        }
        
    }
    
    static func resizeImage(image: UIImage?, toScale scale: CGFloat) -> UIImage {
        if let image = image {
            let oldWidth = image.size.width
            let oldHeight = image.size.height
            let newSize = CGSize(width: oldWidth * scale, height: oldHeight * scale)
            let renderer = UIGraphicsImageRenderer(size: newSize)
            return renderer.image { (context) in
                image.draw(in: CGRect(origin: .zero, size: newSize))
            }
        }
        else {
            return UIImage()
        }
        
    }
}
