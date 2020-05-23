//
//  NotificationsCountIcon.swift
//  Fithub
//
//  Created by admin on 20/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import EasyPeasy

class NotificationsCountIcon: UIView {
    
    let label = Label(label: "0", fontSize: 25)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.easy.layout(Size(44))
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 22
        self.layer.borderColor = FithubUI.Colors.greenHighlight.cgColor
        
        label.textColor = FithubUI.Colors.greenHighlight
        self.addSubview(label)
        label.easy.layout(Center())
    }
    
    func updateDisplayCount(newVal: Int) {
        label.text = String(newVal)
        guard newVal == 0 else {
            label.textColor = FithubUI.Colors.yellowHighlight
            self.layer.borderColor = FithubUI.Colors.yellowHighlight.cgColor
            return
        }
        label.textColor = FithubUI.Colors.greenHighlight
        self.layer.borderColor = FithubUI.Colors.greenHighlight.cgColor
    }
}
