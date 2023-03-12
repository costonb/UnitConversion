//
//  ContentView.swift
//  UnitConversion
//
//  Created by Brandon Coston on 2/27/23.
//

import SwiftUI

enum TimeUnits: String, CaseIterable {
    case seconds = "Seconds"
    case minutes = "Minutes"
    case hours = "Hours"
    case days = "Days"
    case years = "Years"
}

struct ContentView: View {
    @State private var startingUnit = TimeUnits.minutes
    @State private var endingUnit = TimeUnits.seconds
    @State private var numberToConvert: Double = 12.0
    @FocusState private var numberEntryFocus: Bool
    
    let unitConversion: [TimeUnits: Double] = [
        .seconds: 1,
        .minutes: 60,
        .hours: 60 * 60,
        .days: 60 * 60 * 24,
        .years: 60 * 60 * 24 * 365
    ]
    
    var convertedNumber: Double {
        let startingConversion = unitConversion[startingUnit] ?? 1
        let endingConversion = unitConversion[endingUnit] ?? 1
        let convertedValue = numberToConvert * startingConversion / endingConversion
        return convertedValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Input Unit", selection: $startingUnit) {
                        ForEach(TimeUnits.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }
                
                Section {
                    Picker("Output Unit", selection: $endingUnit) {
                        ForEach(TimeUnits.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .onTapGesture {
                        numberEntryFocus = false
                    }
                }
                
                Section {
                    TextField("Value to convert", value: $numberToConvert, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($numberEntryFocus)
                } header: {
                    Text("Value to convert")
                }
                
                Section {
                    Text(convertedNumber, format: .number)
                } header: {
                    Text("Converted value")
                }
            }
            .navigationTitle("Unit Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        numberEntryFocus = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
