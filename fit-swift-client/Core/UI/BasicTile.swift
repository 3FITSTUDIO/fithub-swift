//
//  BasicTile.swift
//  fit-swift-client
//
//  Created by admin on 03/12/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class BasicTile: UIView {
    
    enum TileSize {
        case small, big, wide, cell, roundButton, custom
    }
    
    var size: TileSize = .small
    var customHeight: CGFloat = 0
    var customWidth: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
    }
    
    convenience init(size: TileSize = .small) {
        self.init()
        setup()
    }
    
    convenience init(customHeight: CGFloat, customWidth: CGFloat) {
        self.init()
        self.customHeight = customHeight
        self.customWidth = customWidth
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        let height: CGFloat = {
            switch size {
            case .small: return 152
            case .big: return 323
            case .wide: return 73
            case .cell: return 104
            case .roundButton: return 80
            case .custom: return customHeight
                
            }
        }()
        let width: CGFloat = {
            switch size {
            case .small: return 159
            case .big: return 337
            case .wide: return 337
            case .cell: return 337
            case .roundButton: return 80
            case .custom: return customWidth
            }
        }()
        
//       TODO: labelki:  kolory, czcionki, rozmiary, reszta do subklasowania
        
        self.addShadow()
        self.layer.cornerRadius = size == .roundButton ? 40 : 20
        self.easy.layout(Height(height), Width(width))
        self.backgroundColor = FithubUI.Colors.whiteOneHundred
    }
}
