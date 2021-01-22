//
//  ProjectHeaderView.swift
//  UltimatePortfolio
//
//  Created by Marc on 22.01.21.
//

import SwiftUI
struct ProjectHeaderView: View {
    @ObservedObject var project: Project
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(project.projectTitle)
                ProgressView(value: project.completionAmmount)
                    .accentColor(Color(project.projectColor))
        }
            Spacer()
            
            NavigationLink(destination: EditProjectView(project: project)) {
                Image(systemName: "square.and.pencil")
                    .imageScale(.large)
            }
        }
        .padding(.bottom, 10)
    }
}

struct ProjectHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectHeaderView(project: Project.example)
    }
}
