//
//  HomeView.swift
//  My Income
//
//  Created by Lalu Iman Abdullah on 08/07/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: IncomeViewModel
    @State private var showAddItemView = false
    
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: IncomeViewModel(context: context))
    }

    var body: some View {
        ZStack {
            VStack {
                VStack {
                    VStack {
                        Text("My total Income:")
                            .font(.title2)
                        HStack {
                            Text("Rp")
                                .font(.title)
                                .fontWeight(.semibold)
                            Text("\(viewModel.totalIncome, specifier: "%.2f")")
                                .font(.largeTitle).bold()
                                .foregroundStyle(.green)
                        }
                        Divider()
                    }
                    .padding()
                    ItemListView(viewModel: viewModel)
                }
                Spacer()
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showAddItemView = true
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 50, height: 60)
                            .cornerRadius(22.5)
                    }
                    .padding()
                    .sheet(isPresented: $showAddItemView) {
                        AddView(viewModel: viewModel)
                            .frame(width: 310, height: 250)
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let context = DataController().container.viewContext
        HomeView(context: context)
    }
}
