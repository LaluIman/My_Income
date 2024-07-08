//
//  IncomeViewModel.swift
//  My Income
//
//  Created by Lalu Iman Abdullah on 08/07/24.
//

import SwiftUI
import CoreData

class IncomeViewModel: ObservableObject {
    @Published var moneyInputs: [Income] = []
    
    private var viewContext: NSManagedObjectContext
    
    var totalIncome: Double {
        moneyInputs.reduce(0) { $0 + $1.amount }
    }
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchMoneyInputs()
    }
    
    func fetchMoneyInputs() {
        let request: NSFetchRequest<Income> = Income.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Income.date, ascending: false) // Sort by date in descending order
        request.sortDescriptors = [sortDescriptor]
        
        do {
            moneyInputs = try viewContext.fetch(request)
        } catch {
            print("Failed to fetch money inputs: \(error)")
        }
    }
    
    func addMoneyInput(amount: Double, description: String, date: Date) {
        let newInput = Income(context: viewContext)
        newInput.amount = amount
        newInput.descriptionText = description
        newInput.date = date
        
        saveContext()
        fetchMoneyInputs()
    }
    
    func deleteMoneyInput(at offsets: IndexSet) {
        offsets.map { moneyInputs[$0] }.forEach(viewContext.delete)
        saveContext()
        fetchMoneyInputs()
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
