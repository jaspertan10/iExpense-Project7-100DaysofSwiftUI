//
//  ExpenseView.swift
//  iExpense
//
//  Created by Jasper Tan on 12/30/24.
//

import SwiftData
import SwiftUI

struct ExpenseView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    
    var body: some View {
        List {
            ForEach(expenses) { expense in
                HStack {
                    VStack(alignment: .leading) {
                        Text(expense.name)
                            .font(.headline)
                        
                        Text(expense.type)
                            .font(.caption)
                    }
                    Spacer()
                    expenseAmountTextView(expenseItem: expense)
                }
            }
            .onDelete(perform: removeItems)
        }
    }
    
    init(expenseType: String, sortOrder: [SortDescriptor<Expense>]) {
        _expenses = Query(filter: #Predicate<Expense> { expense in
            expense.type == expenseType
        }, sort: sortOrder)
    }
    
    func expenseAmountTextView(expenseItem: Expense) -> some View {
        
        var color: Color = .green
        
        if (expenseItem.amount <= 10) {
            color = .green
        }
        else if (expenseItem.amount <= 100) {
            color = .orange
        }
        else {
            color = .red
        }
        
        return (Text(expenseItem.amount, format: .currency(code: expenseItem.currencyCode))
            .foregroundStyle(color))
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            
            // find this book in our query
            let expense = expenses[offset]
            
            // delete it from the context
            modelContext.delete(expense)
        }
    }
}

#Preview {
    ExpenseView(expenseType: "Personal", sortOrder: [SortDescriptor(\Expense.name)])
        .modelContainer(for: Expense.self)
}
