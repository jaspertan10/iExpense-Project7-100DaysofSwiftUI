//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Jasper Tan on 11/27/24.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
