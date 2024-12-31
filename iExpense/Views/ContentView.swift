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
    
    
    //Order of sort for expenses
    @State private var sortOrder = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.type),
    ]
    
    @State private var expenseType: String = "Personal"
    
    var body: some View {
        NavigationStack {
            
            ExpenseView(expenseType: expenseType, sortOrder: sortOrder)
            .navigationTitle("iExpense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\Expense.name),
                                    SortDescriptor(\Expense.type),
                                ])
                            
                            Text("Sort by Price")
                                .tag([
                                    SortDescriptor(\Expense.amount),
                                    SortDescriptor(\Expense.type),
                                ])
                        }
                    }
                }
                
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
                
                ToolbarItem(placement: .topBarLeading) {
                    if (expenseType == "Personal") {
                        Button("Business Expenses", systemImage: "briefcase.fill") {
                            expenseType = "Business"
                        }
                    }
                    else if (expenseType == "Business") {
                        Button("Personal Expenses", systemImage: "house.fill") {
                            expenseType = "Personal"
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView()
            }
        }
    }
    
}

#Preview {
    ContentView()
}
