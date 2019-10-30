//
//  FithubUI.swift
//  fit-swift-client
//
//  Created by admin on 20/10/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit

class FithubUI {
    
    struct Colors {
        static let backgroundGradient: CAGradientLayer = {
            // #AD94D0
            let backgroundGradientTop = UIColor(r: 173, g: 148, b: 208).cgColor
            // #661F80
            let backgroundGradientBottom = UIColor(r: 102, g: 31, b: 128).cgColor
            
            let gl = CAGradientLayer()
            gl.colors = [backgroundGradientTop, backgroundGradientBottom]
            gl.locations = [0.0, 1.0]
            return gl
        }()
        
        // #7B2286
        static let buttonTextColorFullOpacity = UIColor(r: 123, g: 34, b: 134)
        static let buttonTextColorSixtyOpacity = UIColor(r: 123, g: 34, b: 134, alpha: 0.6)
    }
    
}




