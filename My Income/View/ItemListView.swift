//
//  ItemListView.swift
//  My Income
//
//  Created by Lalu Iman Abdullah on 08/07/24.
//

import SwiftUI

struct ItemListView: View {
    @ObservedObject var viewModel: IncomeViewModel

    var body: some View {
        if $viewModel.moneyInputs.isEmpty {
            VStack {
                VStack {
                    Text("There are no Income")
                        .foregroundColor(.gray)
                        .font(.title2).bold()
                    Text("🙅‍♂️")
                        .font(.largeTitle)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        } else {
            List {
                ForEach(viewModel.moneyInputs, id: \.self) { input in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Rp")
                                .foregroundStyle(.white)
                            Text("\(input.amount, specifier: "%.2f")")
                                .foregroundStyle(.green)
                        }
                        .font(.title).bold()
                    .padding(.bottom, 5)
                        HStack {
                            Image(systemName: "doc.fill")
                                .font(.title3)
                            Text("\(input.descriptionText ?? "")")
                                .font(.title3)
                                .fontWeight(.semibold)
                            .padding(.bottom,2)
                        }
                        HStack {
                            Image(systemName: "calendar")
                                .font(.title3)
                            Text("\(input.date ?? Date(), formatter: dateFormatter)")
                                .font(.title3)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .onDelete(perform: deleteItems)
                .listRowSeparator(.hidden)
                .listStyle(.plain)
            }
        }
    }
    private func deleteItems(at offsets: IndexSet) {
            viewModel.deleteMoneyInput(at: offsets)
        }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        let context = DataController().container.viewContext
        let viewModel = IncomeViewModel(context: context)
        ItemListView(viewModel: viewModel)
            .environment(\.managedObjectContext, context)
    }
}

