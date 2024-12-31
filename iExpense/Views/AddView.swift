//
//  AddView.swift
//  iExpense
//
//  Created by Jasper Tan on 11/28/24.
//

import SwiftData
import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.modelContext) var modelContext
    
    @State private var name: String = "Expense name"
    @State private var type: String = "Personal"
    @State private var amount: Double = 0.0
    @State private var currencyCode: String = "USD"
    
    let types = ["Business", "Personal"]
    let currencyCodeTypes: [String] = ["USD", "EUR", "CNY", "JPY", "AUD"]
    
    var body: some View {
        NavigationStack {
            Form {
                //TextField("Name", text: $name)
                
                Picker("Expense Type", selection: $type) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: currencyCode))
                    .keyboardType(.decimalPad)
                
                Picker("Currency Code", selection: $currencyCode) {
                    ForEach(currencyCodeTypes, id: \.self) { code in
                        Text(code)
                    }
                }
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let expense: Expense = Expense(name: name, type: type, amount: amount, currencyCode: currencyCode)
                    modelContext.insert(expense)
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
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    
    AddView()
}
