//
//  ContentView.swift
//  iExpense
//
//  Created by Jasper Tan on 11/27/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    /* Sheets view states */
    @State private var showingAddExpense = false

    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    
    var body: some View {
        NavigationStack {
            
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
            
//            List {
//                ForEach(expenses) { item in
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text(item.name)
//                                .font(.headline)
//                            Text(item.type)
//                                .font(.caption)
//                        }
//
//                        Spacer()
//                        expenseAmountTextView(expenseItem: item, currencyCode: expenses.currencyType)
//                    }
//                }
//                .onDelete { offset in
//                    removeItems(at: offset)
//                }
//            }
            .navigationTitle("iExpense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddView()
                    } label: {
                        //View
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView()
            }
        }
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
    ContentView()
}
