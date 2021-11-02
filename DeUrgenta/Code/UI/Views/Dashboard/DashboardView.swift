//
//  DashboardView.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 23.07.2021.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isFirstTimeVisit {
                HStack {
                    BigTitleLabel(title: "Felicitări, Cristi!")
                    Spacer()
                }
                
                Spacer().frame(height: 40)
                
                FormMessageLabel(message: "Contul tău a fost validat.")
                
                Spacer().frame(height: 18)
                
                HStack {
                    BodyTextLabel(text: "Mai departe te rugăm să finalizezi configurarea profilului tău.")
                        .foregroundColor(.regularText)
                    Spacer()
                }
                
                Spacer().frame(height: 50)
            } else {
                HStack {
                    Image.appIconLarge
                    Spacer()
                }
                
                Spacer().frame(height: 40)
                
                HStack {
                    BigTitleLabel(title: "Configurează-ți contul")
                    Spacer()
                }
                
            }
            
            VStack(spacing: 16) {
                ForEach(ViewModel.allItems, id: \.id) { item in
                    NavigationLink {
                        switch item.id {
                        case .addresses:
                            AddressEntryView()
                        default:
                            Text("Not handled")
                        }
                    } label: {
                        DashboardRow(item: item, enabled: viewModel.areAllOptionsAvailable || (item.id == .addresses))
                    }
                    
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
    }
    
}

struct DashboardRow: View {
    let item: DashboardView.ViewModel.Item
    let enabled: Bool
    
    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: 14) {
                VStack(alignment: .center) {
                    Image("\(item.iconName)")
                        .frame(width: 32, height: 32)
                }
                .frame(width: 40, height: 40, alignment: .center)
                .overlay(
                    Circle()
                        .stroke(Color.accent, lineWidth: 8)
                )

                Text("\(item.name)")
                    .font(.appTitle)
                    .foregroundColor(.mainForeground)
                
                Spacer()

                Image.chevron
                
            }
            .frame(height: 48)
            .opacity(enabled ? 1 : 0.5)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DashboardView()
        }
    }
}
