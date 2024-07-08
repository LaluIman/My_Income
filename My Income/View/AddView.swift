//
//  AddView.swift
//  My Income
//
//  Created by Lalu Iman Abdullah on 08/07/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: IncomeViewModel

    @State private var amount: String = ""
    @State private var descriptionText: String = ""
    @State private var date = Date()

    // Formatter for amount display
    private let amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.currencySymbol = "Rp "
        formatter.maximumFractionDigits = 0 // Remove this line to show decimal digits
        return formatter
    }()

    // Formatter for date display
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d/M/y"
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                Text("Amount of money 🤑")
                    .font(.title3)
                    .fontWeight(.bold)
                TextField("", text: $amount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            VStack(alignment: .leading){
                Text("Add a description 👨‍💻")
                    .font(.title3)
                    .fontWeight(.bold)
                TextField("", text: $descriptionText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            VStack(alignment: .leading){
                Text("Mark the date! ✍️")
                    .font(.title3)
                    .fontWeight(.bold)
                DatePicker("", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.compact)
                .environment(\.locale, Locale(identifier: "en_US"))
            } // Set locale for DatePicker

            HStack {
                Button(action: cancel) {
                    Text("Cancel")
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(.red)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                .padding()
                
                Button(action: addItem) {
                    Text("Add")
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                .padding()
                .disabled(amount.isEmpty || descriptionText.isEmpty)
            }
        }
        .padding()
    }

    private func cancel() {
        presentationMode.wrappedValue.dismiss()
    }

    private func addItem() {
        guard !amount.isEmpty, !descriptionText.isEmpty else {
            return
        }

        // Convert formatted amount string back to double for storage
        let formattedAmount = amount.replacingOccurrences(of: amountFormatter.currencySymbol, with: "").replacingOccurrences(of: amountFormatter.groupingSeparator, with: "")
        let amountValue = Double(formattedAmount) ?? 0

        viewModel.addMoneyInput(amount: amountValue, description: descriptionText, date: date)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        let context = DataController().container.viewContext
        let viewModel = IncomeViewModel(context: context)
        AddView(viewModel: viewModel)
            .environment(\.managedObjectContext, context)
    }
}



