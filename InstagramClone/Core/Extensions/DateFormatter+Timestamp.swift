//
//  DateFormatter+Timestamp.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 08/06/25.
//

import Foundation

extension DateFormatter {
    static let postDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}
