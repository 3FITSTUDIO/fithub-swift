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

class NewRecordButton: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
    }
    convenience init(label: String) {
        self.init()
        self.easy.layout(Width(120), Height(90))
        self.layer.cornerRadius = 20
        self.layer.borderColor = FithubUI.Colors.hospitalGreen.cgColor
        self.layer.borderWidth = 2
        let label = Label(label: label, fontSize: 20)
        label.textColor = FithubUI.Colors.neonGreen
        self.addSubview(label)
        label.easy.layout(Center())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AddNewPopUp: UIViewController {
    enum Route: String {
        case newWeight
        case newCalories
    }
    private let router = AddNewPopUpRouter()
    
    let container = UIView()
    let closeButton = Label(label: "close", fontSize: 20)
    
    let weightButton = NewRecordButton(label: "weight")
    let caloriesButton = NewRecordButton(label: "calories")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.easy.layout(Height(150), Width(200))
        view.addSubview(container)
        container.easy.layout(Height(200), Width(310), Center())
        setupLayout()
        setupButtons()
    }
    
    private func setupLayout() {
        let newLabel = Label(label: "new", fontSize: 30)
        newLabel.textColor = .black
        container.backgroundColor = .white
        container.layer.cornerRadius = 20
        container.addSubviews(subviews: [closeButton, newLabel])
        closeButton.easy.layout(CenterX(), Bottom(10))
        newLabel.easy.layout(CenterX(), Top(10))
        closeButton.textColor = FithubUI.Colors.weirdGreen
        
        let closeArea = UIView()
        container.addSubview(closeArea)
        closeArea.easy.layout(Bottom(), Height(40), Left(), Right())
        closeArea.addGesture(target: self, selector: #selector(self.closePopup(_:)))
    }
    
    private func setupButtons() {
        container.addSubviews(subviews: [weightButton, caloriesButton])
        weightButton.easy.layout(Left(25), CenterY())
        caloriesButton.easy.layout(Right(25), CenterY())
        weightButton.addGesture(target: self, selector: #selector(self.newWeightTapped(_:)))
        caloriesButton.addGesture(target: self, selector: #selector(self.newCaloriesTapped(_:)))
    }
}

// MARK: Navigation
extension AddNewPopUp {
    @objc private func closePopup(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func newWeightTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        router.route(to: Route.newWeight.rawValue, from: self)
    }
    
    @objc private func newCaloriesTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        router.route(to: Route.newCalories.rawValue, from: self)
    }
}
