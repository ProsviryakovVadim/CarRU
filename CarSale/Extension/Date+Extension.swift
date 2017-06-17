//
//  Date+Extension.swift
//  CarSale
//
//  Created by Vadim on 5/31/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import Foundation

extension Date {
    
    var reviewsFormattedString: String {
        let now = Date()
        let delta = now.timeIntervalSince(self)
        let today = TimeInterval(Int64(now.timeIntervalSince1970) % (3600 * 24))
        let df = DateFormatter()
        if delta < today {
            df.dateFormat = "HH:mm"
            return String.localizedStringWithFormat(NSLocalizedString("Сегодня %@", comment: ""), df.string(from: self))
        }
        if delta < today + 3600 * 24 {
            df.dateFormat = "HH:mm"
            return String.localizedStringWithFormat(NSLocalizedString("Вчера %@", comment: ""), df.string(from: self))
        }
        if delta < today + 3600 * 24 * 7 {
            df.dateFormat = "EEEE HH:mm"
            return df.string(from: self).capitalized
        }
        df.dateFormat = "d MMMM HH:mm"
        return df.string(from: self)
    }
    
}
