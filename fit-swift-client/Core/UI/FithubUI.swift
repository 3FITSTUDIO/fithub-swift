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
        static let weirdGreen = UIColor(r: 150, g: 209, b: 166)
        static let classicWhite = UIColor(r: 239, g: 239, b: 239)
        static let stepsCircleGray = UIColor(r: 220, g: 224, b: 220)
        static let highlight = UIColor(r: 63, g: 147, b: 128)
        
        static let whiteOneHundred = UIColor(r: 255, g: 255, b: 255)
        static let blackOneHundred = UIColor(r: 0, g: 0, b: 0)
    }
    
}




