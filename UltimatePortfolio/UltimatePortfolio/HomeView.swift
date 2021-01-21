//
//  HomeView.swift
//  UltimatePortfolio
//
//  Created by Marc on 21.01.21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        NavigationView{
            VStack{
                Button("Add Data") {
                    dataController.deleteAll()
                    try? dataController.createSampleDate()
                }
            }
        }.navigationTitle("Home")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
