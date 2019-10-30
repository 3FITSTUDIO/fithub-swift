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
    
    struct Fonts {
        static let mainAvenir: UIFont = {
            guard let customFont = UIFont(name: "Avenir", size: UIFont.labelFontSize) else {
                fatalError("""
                    Failed to load the "CustomFont-Light" font.
                    Make sure the font file is included in the project and the font name is spelled correctly.
                    """
                )
            }
            return customFont
        }()
    }
    
    struct Colors {
        static let backgroundGradient: CAGradientLayer = {
            // #8743E5
            let backgroundGradientTop = UIColor(r: 135, g: 67, b: 229).cgColor
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




