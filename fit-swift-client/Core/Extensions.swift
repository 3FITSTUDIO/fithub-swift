//
//  Extensions.swift
//  fit-swift-client
//
//  Created by admin on 21/10/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    convenience init(bundleName: StaticString) {
        self.init(named: "\(bundleName)")!
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
    
    convenience init(r: Int, g: Int, b: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
    }
}

extension UIViewController {
    func setupCommonTraits() {
        setBackgroundColor()
        hideKeyboardWhenTappedAround()
    }
    func setBackgroundColor() {
        view.backgroundColor = FithubUI.Colors.weirdGreen
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIView {
    func addSubviews(subviews: [UIView]) {
        subviews.forEach { self.addSubview($0) }
    }
    
    func addGesture(target: UIViewController, selector: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: selector)
        self.addGestureRecognizer(tap)
    }
    
    func addShadow() {
        self.layer.shadowColor = FithubUI.Colors.blackOneHundred.cgColor
        self.layer.shadowOpacity = 0.16
        self.layer.shadowOffset = CGSize(width: 0, height: 10.0)
        self.layer.shadowRadius = 10
    }
}

extension UILabel {
    func fontSize(size: CGFloat) {
        self.font = self.font.withSize(size)
    }
    
    func setFont(fontName:  UIFont) {
        self.font = UIFontMetrics.default.scaledFont(for: fontName)
    }
}

extension UITextField {
    func increaseFontSize (toSize: CGFloat) {
        self.font =  UIFont(name: "Avenir-Heavy", size: toSize)
    }
}

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from filename: String) -> T {
        guard let json = url(forResource: filename, withExtension: nil) else {
            fatalError("Failed to locate \(filename) in app bundle.")
        }
        
        guard let jsonData = try? Data(contentsOf: json) else {
            fatalError("Failed to load \(filename) from app bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let result = try? decoder.decode(T.self, from: jsonData) else {
            fatalError("Failed to decode \(filename) from app bundle.")
        }
        return result
    }
}

extension Double {
    var truncateTrailingZeros: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%g", self) : String(self)
    }
}
