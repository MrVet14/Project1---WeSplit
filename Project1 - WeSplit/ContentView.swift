//
//  ContentView.swift
//  Project1 - WeSplit
//
//  Created by Vitali Vyucheiski on 5/31/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let currency = Locale.current.currencyCode ?? "USD"
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalCheckAmount: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currency))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople, content: {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    })
                }
                
                Section {
                    Picker("TipPercentage", selection: $tipPercentage, content: {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    })
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: currency))
                } header: {
                    Text("Amount per person:")
                }
                
                Section {
                    Text(totalCheckAmount, format: .currency(code: currency))
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Total check amount:")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11 Pro Max")
    }
}
