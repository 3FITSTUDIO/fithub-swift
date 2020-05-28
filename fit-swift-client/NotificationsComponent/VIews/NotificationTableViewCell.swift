//
//  NotificationTableViewCell.swift
//  fit-swift-client
//
//  Created by admin on 18/05/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import UIKit
import EasyPeasy

class NotificationTableViewCell: UITableViewCell {
    let container = UIView()
    let cellView = UIView()
    
    let dateValue = Label(label: "", fontSize: 10)
    let messageContent = Label(label: "", fontSize: 14)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateValue.text = ""
        messageContent.text = ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.contentView.backgroundColor = .clear
        
        if selected {
            cellView.layer.borderWidth = 2
            cellView.layer.borderColor = FithubUI.Colors.greenHighlight.cgColor
        }
        else {
            cellView.layer.borderWidth = 0
        }
    }
    
    private func setupLayout() {
        selectedBackgroundView?.easy.layout(Width(337))
        backgroundColor = .clear
        contentView.addSubview(container)
        contentView.easy.layout(Height(155), Width(337), Center())
        container.easy.layout(Height(155), Width(337), Center())
        container.backgroundColor = FithubUI.Colors.weirdGreen
        
        container.addSubview(cellView)
        cellView.easy.layout(Left(), Right(), Top(), Bottom(10))
        cellView.backgroundColor = FithubUI.Colors.whiteOneHundred
        cellView.layer.cornerRadius = 19
        cellView.addShadow()
        
        cellView.addSubviews(subviews: [dateValue, messageContent])
        dateValue.easy.layout(CenterX(), Top(15))
        messageContent.easy.layout(Top(5).to(dateValue), Left(10), Right(10), Bottom(5))
        dateValue.textColor = FithubUI.Colors.greenHighlight
        messageContent.textColor = .black
        messageContent.textAlignment = .justified
        messageContent.lineBreakMode = .byWordWrapping
        messageContent.numberOfLines = 4
    }
    
    func configure(withData data: FithubNotification) {
        dateValue.text = data.date
        messageContent.text = data.message
    }
}
