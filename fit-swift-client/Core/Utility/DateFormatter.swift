//
//  DateFormatter.swift
//  fit-swift-client
//
//  Created by admin on 19/01/2020.
//  Copyright © 2020 Dominik Urbaez Gomez. All rights reserved.
//

import Foundation

class FitHubDateFormatter {
    static func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dateFormatted = formatter.string(from: date)
        return dateFormatted
    }
}
