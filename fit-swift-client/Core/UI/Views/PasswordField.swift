//
//  PasswordField.swift
//  fit-swift-client
//
//  Created by admin on 05/11/2019.
//  Copyright © 2019 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class PasswordField : TextField {
    override func settings() {
        super.settings()
        self.textField.isSecureTextEntry = true
    }
}
