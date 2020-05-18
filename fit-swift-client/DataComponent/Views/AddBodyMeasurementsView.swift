//
//  AddBodyMeasurementsView.swift
//  fit-swift-client
//
//  Created by admin on 17/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import UIKit
import EasyPeasy

class AddBodyMeasurementsView: UIView {
    let margin: CGFloat = 72
    // Labels
    
    // body measures
    let neckLabel = Label(label: "Neck", fontSize: 20)
    let chestLabel = Label(label: "Chest", fontSize: 20)
    let bicepLabel = Label(label: "Bicep", fontSize: 20)
    let forearmLabel = Label(label: "Forearm", fontSize: 20)
    let stomachLabel = Label(label: "Stomach", fontSize: 20)
    let waistLabel = Label(label: "Waist", fontSize: 20)
    let thighLabel = Label(label: "Thigh", fontSize: 20)
    let calfLabel = Label(label: "Calf", fontSize: 20)
    
    // Fields
    
    // body measures
    let neckField = TextField(placeholder: "", borderColor: FithubUI.Colors.weirdGreen.cgColor, width: 75)
    let chestField = TextField(placeholder: "", borderColor: FithubUI.Colors.weirdGreen.cgColor, width: 75)
    let bicepField = TextField(placeholder: "", borderColor: FithubUI.Colors.weirdGreen.cgColor, width: 75)
    let forearmField = TextField(placeholder: "", borderColor: FithubUI.Colors.weirdGreen.cgColor, width: 75)
    let stomachField = TextField(placeholder: "", borderColor: FithubUI.Colors.weirdGreen.cgColor, width: 75)
    let waistField = TextField(placeholder: "", borderColor: FithubUI.Colors.weirdGreen.cgColor, width: 75)
    let thighField = TextField(placeholder: "", borderColor: FithubUI.Colors.weirdGreen.cgColor, width: 75)
    let calfField = TextField(placeholder: "", borderColor: FithubUI.Colors.weirdGreen.cgColor, width: 75)
    
    public var dataFields = [TextField]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
        dataFields = [neckField, chestField, bicepField, forearmField, stomachField, waistField, thighField, calfField]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.easy.layout(Height(301), Width(337))
        self.backgroundColor = FithubUI.Colors.weirdGreen
        self.backgroundColor = .white
        self.layer.cornerRadius = 19
        self.addShadow()
        [neckLabel, chestLabel, bicepLabel, forearmLabel, stomachLabel, waistLabel, thighLabel, calfLabel].forEach { $0.textColor = FithubUI.Colors.highlight }
        [neckField, chestField, bicepField, forearmField, stomachField, waistField, thighField, calfField].forEach { $0.textField.textColor = .black }
    }
    
    private func layout() {
        self.addSubviews(subviews: [neckLabel, chestLabel, bicepLabel, forearmLabel, stomachLabel, waistLabel, thighLabel, calfLabel])
        neckLabel.easy.layout(Left(margin), Top(3))
        var previous: UIView = neckLabel
        [chestLabel, bicepLabel, forearmLabel, stomachLabel, waistLabel, thighLabel, calfLabel].forEach {
            $0.easy.layout(Left(margin), Top(10).to(previous))
            previous = $0
        }
        
        self.addSubviews(subviews: [neckField, chestField, bicepField, forearmField, stomachField, waistField, thighField, calfField])
        neckField.easy.layout(Left(45).to(neckLabel), Top(2))
        previous = neckField
        [chestField, bicepField, forearmField, stomachField, waistField, thighField, calfField].forEach {
            $0.easy.layout(Left(45).to(neckLabel), Top(-1).to(previous))
            previous = $0
        }
    }
}
