//
//  DashboardViewController.swift
//  fit-swift-client
//
//  Created by admin on 05/11/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class DashboardViewController: UIViewController {
    enum Route: String {
        case logout
    }
    let router = DashboardRouter()
    let viewModel = DashboardViewModel()
    
    
    private let container = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCommonTraits()
        setup()
    }
    
    private func setup(){
        view.addSubview(container)
        container.easy.layout(Edges())
    
        setupButtons()
        let tile = BasicTile(size: .big)
        container.addSubview(tile)
        tile.easy.layout(Center())
    }
    
    private func setupButtons() {
    }
}

// MARK: Routing

extension DashboardViewController {}

