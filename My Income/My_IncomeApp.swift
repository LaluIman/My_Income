//
//  My_IncomeApp.swift
//  My Income
//
//  Created by Lalu Iman Abdullah on 08/07/24.
//

import SwiftUI

@main
struct My_IncomeApp: App {
    let dataController = DataController()

        var body: some Scene {
            WindowGroup {
                HomeView(context: dataController.container.viewContext)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .frame(minWidth: 100, maxWidth: 500, minHeight: 100, maxHeight: 500)
            }
            .defaultSize(width: 500, height: 400)
            .windowResizability(.contentSize)
        }
}
