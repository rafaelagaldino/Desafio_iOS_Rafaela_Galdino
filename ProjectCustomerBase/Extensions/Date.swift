//
//  Date.swift
//  ProjectCustomerBase
//
//  Created by Rafaela Galdino on 04/07/20.
//  Copyright © 2020 Rafaela Galdino. All rights reserved.
//

import Foundation
extension Date {
    func formatterDate(_ date: Date) -> NSString? {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        print("Date", dateFormatterPrint.string(from: date))
        return dateFormatterPrint.string(from: date) as NSString
    }
}
