//
//  SettingsView.swift
//  iExpense
//
//  Created by Jasper Tan on 11/29/24.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var expenses: Expenses
    
    @State private var selectedCurrency: String = "USD"
    @State private var supportedCurrency: [String] = ["USD", "AUD", "CAD", "EUR", "JPY", "CNY"]
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Currency", selection: $selectedCurrency) {
                    ForEach(supportedCurrency, id: \.self) { currency in
                        Text(currency)
                    }
                }
                .onAppear {
                    selectedCurrency = expenses.currencyType
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    expenses.currencyType = selectedCurrency
                    dismiss()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(.red)
                }
            }
        }
    }
}

#Preview {
    SettingsView(expenses: Expenses())
}
