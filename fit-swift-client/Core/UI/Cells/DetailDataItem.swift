//
//  DetailDataItem.swift
//  fit-swift-client
//
//  Created by admin on 28/04/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import EasyPeasy
import Foundation
import UIKit

class DetailDataItem: UICollectionViewCell {
    var buttonView = UIView()
    func configure(view: UIView) {
        buttonView = view
        self.addSubview(buttonView)
        buttonView.easy.layout(Edges())
    }
    
    override func prepareForReuse() {
        buttonView.removeFromSuperview()
    }
}
