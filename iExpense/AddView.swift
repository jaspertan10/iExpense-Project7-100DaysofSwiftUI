//
//  AddView.swift
//  iExpense
//
//  Created by Jasper Tan on 11/28/24.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var expenses: Expenses
    
    @State private var name: String = "Expense name"
    @State private var type: String = "Personal"
    @State private var amount: Double = 0.0
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            Form {
                //TextField("Name", text: $name)
                
                Picker("Expense Type", selection: $type) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: expenses.currencyType))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    expenses.items.append(ExpenseItem(name: name, type: type, amount: amount))
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
    
    let expenses: Expenses = Expenses()
    expenses.items.append(ExpenseItem(name: "Sample expense", type: "Personal", amount: 50.00))
    
    return AddView(expenses: expenses)
}
