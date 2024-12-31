//
//  Expenses.swift
//  iExpense
//
//  Created by Jasper Tan on 12/30/24.
//

import Foundation
import SwiftData

@Model
class Expense {
    
    var name: String
    var type: String
    var amount: Double
    var currencyCode: String

    init(name: String, type: String, amount: Double, currencyCode: String) {
        self.name = name
        self.type = type
        self.amount = amount
        self.currencyCode = currencyCode
    }
}


