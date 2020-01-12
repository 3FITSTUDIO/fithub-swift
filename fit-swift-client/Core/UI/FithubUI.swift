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
            guard let customFont = UIFont(name: "Avenir-Heavy", size: UIFont.labelFontSize) else {
                fatalError("""
                    Failed to load the "Avenir Bold" font.
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
            let backgroundGradientTop = UIColor(r: 67, g: 229, b: 111).cgColor
            // #661F80
            let backgroundGradientBottom = UIColor(r: 78, g: 214, b: 110).cgColor
            
            let gl = CAGradientLayer()
            gl.colors = [backgroundGradientTop, backgroundGradientBottom]
            gl.locations = [0.0, 1.0]
            return gl
        }()
        
        static let weirdGreen = UIColor(r: 67, g: 229, b: 111)
        static let lightishGreen = UIColor(r: 78, g: 214, b: 110)
        static let whiteOneHundred = UIColor(r: 255, g: 255, b: 255)
        static let blackOneHundred = UIColor(r: 0, g: 0, b: 0)
        static let hospitalGreen = UIColor(r: 138, g: 227, b: 159)
        static let neonGreen = UIColor(r: 96, g: 230, b: 78)

    }
    
}




