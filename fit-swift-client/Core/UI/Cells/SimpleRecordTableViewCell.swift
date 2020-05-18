//
//  WeightsTableViewCell.swift
//  fit-swift-client
//
//  Created by admin on 13/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import UIKit
import Foundation
import EasyPeasy

class SimpleRecordTableViewCell: UITableViewCell {
    let container = UIView()
    let margin: CGFloat = 32
    
    // Labels
    // regular
    let dateLabel = Label(label: "Date", fontSize: 20)
    let valueLabel = Label(label: "", fontSize: 20)
    
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
    // regular
    let date = Label(label: "", fontSize: 20)
    let value = Label(label: "", fontSize: 20)
    
    // body measures
    let neck = Label(label: "", fontSize: 20)
    let chest = Label(label: "", fontSize: 20)
    let bicep = Label(label: "", fontSize: 20)
    let forearm = Label(label: "", fontSize: 20)
    let stomach = Label(label: "", fontSize: 20)
    let waist = Label(label: "", fontSize: 20)
    let thigh = Label(label: "", fontSize: 20)
    let calf = Label(label: "", fontSize: 20)
    
    let cellView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sharedLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func sharedLayout() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(container)
        container.easy.layout(Edges())
        container.addSubview(cellView)
        cellView.easy.layout(Top(), Left(), Right(), Bottom(15))
        container.backgroundColor = FithubUI.Colors.weirdGreen
        contentView.backgroundColor = .clear
        cellView.backgroundColor = .white
        cellView.layer.cornerRadius = 19
        cellView.addShadow()
        cellView.addSubviews(subviews: [dateLabel, date])
        dateLabel.easy.layout(Left(margin), Top(14))
        date.easy.layout(Left(25).to(dateLabel, .rightMargin), Top(14))
        [dateLabel, valueLabel, neckLabel, chestLabel, bicepLabel, forearmLabel, stomachLabel, waistLabel, thighLabel, calfLabel].forEach { $0.textColor = FithubUI.Colors.highlight }
        [date, value, neck, chest, bicep, forearm, stomach, waist, thigh, calf].forEach { $0.textColor = .black }
    }
    
    private func layoutForRegular() {
        contentView.easy.layout(Height(119), Width(337))
        cellView.addSubviews(subviews: [valueLabel, value])
        valueLabel.easy.layout(Left(margin), Top(20).to(dateLabel, .bottomMargin))
        value.easy.layout(Left(15).to(valueLabel, .rightMargin), Top(20).to(dateLabel, .bottomMargin))
    }
    
    private func layoutForBodyMeasurements() {
        contentView.easy.layout(Height(351), Width(337))
        cellView.addSubviews(subviews: [neckLabel, chestLabel, bicepLabel, forearmLabel, stomachLabel, waistLabel, thighLabel, calfLabel])
        
        neckLabel.easy.layout(Left(margin), Top(10).to(dateLabel))
        var previous = neckLabel
        [chestLabel, bicepLabel, forearmLabel, stomachLabel, waistLabel, thighLabel, calfLabel].forEach {
            $0.easy.layout(Left(margin), Top(8).to(previous))
            previous = $0
        }
        
        cellView.addSubviews(subviews: [neck, chest, bicep, forearm, stomach, waist, thigh, calf])
        neck.easy.layout(Left(45).to(neckLabel), Top(10).to(dateLabel))
        previous = neck
        [chest, bicep, forearm, stomach, waist, thigh, calf].forEach {
            $0.easy.layout(Left(45).to(neckLabel), Top(8).to(previous))
            previous = $0
        }
    }
    
    func configure(type: DataProvider.DataType, recordData: DataFetched) {
        switch type {
        case .measurements:
            layoutForBodyMeasurements()
        default:
            layoutForRegular()
            valueLabel.text = type.rawValue
        }
        date.text = recordData.date
        
        switch type {
        case .weights:
            value.text = recordData.value.truncateTrailingZeros + " kg"
        case .kcal:
            value.text = recordData.value.truncateTrailingZeros + " kcal"
        case .sleep:
            value.text = recordData.value.truncateTrailingZeros + " hours"
        case .pulse:
            value.text = recordData.value.truncateTrailingZeros + " BPM"
        case .steps:
            value.text = recordData.value.truncateTrailingZeros + " steps"
        case .training:
            value.text = recordData.value.truncateTrailingZeros + " calories burned"
        case .measurements:
            configureWithBodyMeasuresData(data: recordData)
        }
    }
    
    private func configureWithBodyMeasuresData(data: DataFetched) {
        let fields = [neck, chest, bicep, forearm, stomach, waist, thigh, calf]
        for i in 0...7 {
            fields[i].text = data.values[i].truncateTrailingZeros + " cm"
        }
    }
    
    override func prepareForReuse() {
        contentView.easy.layout(Height(119), Width(337))
        [neck, chest, bicep, forearm, stomach, waist, thigh, calf,
         date, value].forEach {
            $0.text = ""
        }
    }
}
