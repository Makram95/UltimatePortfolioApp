//
//  AwardsView.swift
//  UltimatePortfolio
//
//  Created by Marc on 25.01.21.
//

import SwiftUI

struct AwardsView: View {
    static let tag: String? = "Awards"
    
    var columns : [GridItem] {
        [GridItem(.adaptive(minimum: 100, maximum: 100))]
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: columns){
                    ForEach(Award.allAwards) { award in
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: award.image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                                .foregroundColor(Color.secondary.opacity(0.5))
                        })
                    }
                }
            }
            .navigationTitle("Awards")
        }
    }
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        AwardsView()
    }
}
