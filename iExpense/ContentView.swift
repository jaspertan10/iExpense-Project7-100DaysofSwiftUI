//
//  ContentView.swift
//  iExpense
//
//  Created by Jasper Tan on 11/27/24.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items: [ExpenseItem] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                
                //If there are expense items saved, then load the currency type. Else default to USD.
                if let savedCurrencyType = UserDefaults.standard.string(forKey: "Currency") {
                    currencyType = savedCurrencyType
                }
                
                return
            }
        }
        
        
        currencyType = "USD"
        items = []
    }
    
    var currencyType: String = "USD" {
        didSet {
            UserDefaults.standard.set(currencyType, forKey: "Currency")
        }
    }
}

struct ContentView: View {
    
    /* Sheets view states */
    @State private var showingAddExpense = false
    @State private var showSettings = false
    
    @State private var expenses = Expenses()

    
    var body: some View {
        NavigationStack {
            
            List {
                Section("Personal Expenses") {
                    expenseItems(expenseType: "Personal")
                }
                
                
                Section("Business Expenses") {
                    expenseItems(expenseType: "Business")
                }
            }
            .navigationTitle("iExpense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink {
                    AddView(expenses: expenses)
                } label: {
                    //View
                    Image(systemName: "plus")
                }

//                Button("Add Expense", systemImage: "plus") {
//                    showingAddExpense = true
//                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Settings", systemImage: "gearshape") {
                        showSettings = true
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
            .sheet(isPresented: $showSettings) {
                SettingsView(expenses: expenses)
            }
            
//            List {
//                ForEach(expenses.items) { item in
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
        }
    }
    
    func expenseItems(expenseType: String) -> some View {
        ForEach(expenses.items) { item in
            
            if (item.type == expenseType) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                            .font(.caption)
                    }
                    
                    Spacer()
                    expenseAmountTextView(expenseItem: item, currencyCode: expenses.currencyType)
                }
            }
        }
        .onDelete { offset in
            removeItems(at: offset)
        }
    }
    
    func expenseAmountTextView(expenseItem: ExpenseItem, currencyCode: String) -> some View {
        
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
        
        return (Text(expenseItem.amount, format: .currency(code: currencyCode))
            .foregroundStyle(color))
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
