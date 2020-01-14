//
//  AddNewPopUp.swift
//  fit-swift-client
//
//  Created by admin on 14/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class AddNewPopUp: UIViewController {
    let container = UIView()
    let closeButton = Label(label: "close", fontSize: 15)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = CGSize(width: 200, height: 150)
        view.addSubview(container)
        container.easy.layout(Edges())
        setup()
        
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }
    
    private func setup() {
        container.backgroundColor = .white
        container.layer.cornerRadius = 20
        container.addSubview(closeButton)
        closeButton.easy.layout(CenterX(), Bottom(10))
        closeButton.textColor = FithubUI.Colors.weirdGreen
        closeButton.addGesture(target: self, selector: #selector(self.closePopup(_:)))
    }
    
    @objc private func closePopup(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
}
