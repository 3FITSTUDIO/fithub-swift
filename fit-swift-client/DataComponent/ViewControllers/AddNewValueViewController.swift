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

class AddNewValueViewController: BasicComponentViewController {
    enum Route: String {
        case back
        case added
    }
    
    private var type: DataProvider.DataType = .weights
    private let router = AddNewValueRouter()
    private let viewModel = AddNewValueViewModel()
    private var enterLabel = Label()
    private let valueField: TextField = {
        let txtField = TextField(placeholder: "enter the value")
        txtField.easy.layout(Width(160))
        txtField.textField.keyboardType = .decimalPad
        return txtField
    }()
    
    private let bodyMeasurementsField = AddBodyMeasurementsView()
    
    private let datePickerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.easy.layout(Height(200), Width(337))
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = FithubUI.Colors.weirdGreen
        datePicker.setValue(UIColor.white, forKey: "textColor")
        datePicker.datePickerMode = .date
        view.addSubview(datePicker)
        datePicker.easy.layout(Center())
        return view
    }()
    
    private let confirmAddButton = Button(type: .nav, label: "add")
    
    override func viewDidLoad() {
        componentName = "New Value"
        super.viewDidLoad()
        viewModel.vc = self
        styleForType()
    }
    
    convenience init(type: DataProvider.DataType) {
        self.init()
        self.type = type
        enterLabel = Label(label: "Enter new \(type.rawValue) value:", fontSize: 20)
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
        container.addSubviews(subviews: [datePickerView, enterLabel, confirmAddButton])
        confirmAddButton.addGesture(target: self, selector: #selector(confirmAddTapped(_:)))
    }
    
    private func styleForType() {
        switch type {
        case .measurements:
            enterLabel.easy.layout(CenterX(), Top(85))
            datePickerView.easy.layout(CenterX(), Top(5).to(enterLabel))
            container.addSubview(bodyMeasurementsField)
            bodyMeasurementsField.easy.layout(CenterX(), Top(5).to(datePickerView, .bottomMargin))
            confirmAddButton.easy.layout(CenterX(), Bottom(100))
        default:
            enterLabel.easy.layout(CenterX(), Top(200))
            datePickerView.easy.layout(CenterX(), Top(20).to(enterLabel))
            container.addSubview(valueField)
            valueField.easy.layout(CenterX(), Top(40).to(datePickerView, .bottomMargin))
            confirmAddButton.easy.layout(CenterX(), Bottom(150))
        }
    }
    
    // MARK: Navigation
    
    @objc override func backButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        router.route(to: Route.back.rawValue, from: self)
    }
    
    @objc func confirmAddTapped(_ sender: UITapGestureRecognizer? = nil) {
        generator.selectionChanged()
        let datePicker = datePickerView.subviews[0] as! UIDatePicker
        let date = datePicker.date
        if type == .measurements {
            let values = bodyMeasurementsField.dataFields.map { $0.textField.text }
            guard viewModel.validateBodyData(values: values) else {
                displayAlert(type: .invalidDataEntered)
                clearTextFields()
                return
            }
            let valuesUnwrapped = values.map { $0 ?? "" }
            viewModel.postBodyData(values: valuesUnwrapped, date: date) { [weak self] result in
                if result {
                    self?.displayAlert(type: .success)
                }
                else{
                    self?.displayAlert(type: .somethingWentWrong)
                    self?.clearTextFields()
                }
            }
        }
        else {
            let value = valueField.textField.text ?? ""
            guard viewModel.validateEnteredData(value: value) else {
                displayAlert(type: .invalidDataEntered)
                clearTextFields()
                return
            }
            
            viewModel.postNewRecord(value: value, date: date, type: type) { [weak self] result in
                if result {
                    self?.displayAlert(type: .success)
                }
                else{
                    self?.displayAlert(type: .somethingWentWrong)
                    self?.clearTextFields()
                }
            }
        }
    }
    
    func clearTextFields() {
        valueField.textField.text = ""
        bodyMeasurementsField.dataFields.forEach { $0.textField.text = "" }
    }
    
    // MARK: Alert Display
    
    enum AlertTypeMessage {
        case invalidDataEntered
        case somethingWentWrong
        case success
    }
    
    public func displayAlert(type: AlertTypeMessage) {
        switch type {
        case .invalidDataEntered:
            let alertController = UIAlertController(title: "Oops!", message: "Invalid input.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Close", style: .default) { (action:UIAlertAction) in }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        case .somethingWentWrong:
            let alertController = UIAlertController(title: "Oops!", message: "Something went wrong.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Close", style: .default) { (action:UIAlertAction) in }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        case .success:
            let alertController = UIAlertController(title: "Success!", message: "Added new record.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Close", style: .default) { (action:UIAlertAction) in }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
}
