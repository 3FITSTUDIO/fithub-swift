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
    let dateLabel = Label(label: "Date", fontSize: 20)
    let valueLabel = Label(label: "", fontSize: 20)
    let date = Label(label: "", fontSize: 20)
    let value = Label(label: "", fontSize: 20)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.easy.layout(Height(119), Width(337))
        self.contentView.addSubview(container)
        container.easy.layout(Edges())
        let cellView = UIView()
        container.addSubview(cellView)
        cellView.easy.layout(Top(), Left(), Right(), Bottom(15))
        container.backgroundColor = FithubUI.Colors.weirdGreen
        contentView.backgroundColor = .clear
        cellView.backgroundColor = .white
        cellView.layer.cornerRadius = 19
        cellView.addShadow()
        
        cellView.addSubviews(subviews: [dateLabel, valueLabel, date, value])
        dateLabel.easy.layout(Left(32), Top(14))
        valueLabel.easy.layout(Left(32), Top(20).to(dateLabel, .bottomMargin))
        date.easy.layout(Left(25).to(dateLabel, .rightMargin), Top(14))
        value.easy.layout(Left(15).to(valueLabel, .rightMargin), Top(20).to(dateLabel, .bottomMargin))
        [dateLabel, valueLabel].forEach { $0.textColor = FithubUI.Colors.weirdGreen }
        [date, value].forEach { $0.textColor = .black }
    }
    
    func configure(type: String, recordData: Record) {
        valueLabel.text = type == "Weights" ? "Weight" : "Calories"
        date.text = String(recordData.id) + "/1/2020"
        value.text = String(recordData.value[0]) + (type ==  "Weights" ? " kg" : " kcal")
    }
    
    override func prepareForReuse() {
        
    }

}
