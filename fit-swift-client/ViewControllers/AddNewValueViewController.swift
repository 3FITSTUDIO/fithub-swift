//
//  AddNewValueViewController.swift
//  fit-swift-client
//
//  Created by admin on 14/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

public enum NewValueType: String {
    case weight
    case calories
}

class AddNewValueViewController: BasicComponentViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    enum Route: String {
        case back
    }
    
    
    
    private var type: NewValueType = .weight
    private let router = AddNewValueRouter()
    private let viewModel = AddNewValueViewModel()
    
    private let dateTextField: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.easy.layout(Height(200), Width(337))
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = FithubUI.Colors.weirdGreen
        datePicker.setValue(UIColor.white, forKey: "textColor")
        datePicker.datePickerMode = .date
        view.addSubviews(subviews: [datePicker])
        datePicker.easy.layout(Center())
        return view
    }()
    
    private let valueField = PickerView()
    private let confirmAddButton = Button(type: .nav, label: "add")
    
    override func viewDidLoad() {
        componentName = "Add New Value"
        super.viewDidLoad()
    }
    
    convenience init(type: NewValueType) {
        self.init()
        self.type = type
        valueField.picker.dataSource = self
        valueField.picker.delegate = self
        styleForType(type: type)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        super.setup()
        addBottomNavigationBar()
        
        container.addSubviews(subviews: [dateTextField, valueField, confirmAddButton])
        dateTextField.easy.layout(CenterX(), Top(110))
        valueField.easy.layout(Left(30), Top(40).to(dateTextField, .bottomMargin))
        confirmAddButton.easy.layout(CenterX(), Top(80).to(valueField, .bottomMargin))
        valueField.label.text = type == .weight ? "Weight: " : "Calories: "
        confirmAddButton.addGesture(target: self, selector: #selector(self.confirmAddTapped(_:)))
    }
    
    private func styleForType(type: NewValueType) {
        switch type {
        case .weight:
            return
        case .calories:
            return
        }
    }
    
    // MARK: PickerView Delegate, Datasource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return type == .weight ? 201 : 51
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return type == .weight ? String(row) : String(row * 100)
    }
    // MARK: Navigation
    @objc override func backButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func confirmAddTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        let datePicker = dateTextField.subviews[0] as! UIDatePicker
        let date = datePicker.date
        let value = valueField.picker.selectedRow(inComponent: 0)
//        let success = viewModel.postNewRecord(value: value, date: date, type: type)
//        if success {
//            let alertController = UIAlertController(title: "Success!", message: "Added new record.", preferredStyle: .alert)
//            let action1 = UIAlertAction(title: "Close", style: .default) { (action:UIAlertAction) in }
//            alertController.addAction(action1)
//            self.present(alertController, animated: true, completion: nil)
//        }
//        else{
//            let alertController = UIAlertController(title: "Oops!", message: "Something went wrong.", preferredStyle: .alert)
//            let action1 = UIAlertAction(title: "Close", style: .default) { (action:UIAlertAction) in }
//            alertController.addAction(action1)
//            self.present(alertController, animated: true, completion: nil)
//        }
    }
}
