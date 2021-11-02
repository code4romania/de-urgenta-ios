//
//  AddressEntryView.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 28.08.2021.
//

import SwiftUI
import NMAKit

struct AddressEntryView: View {
    @StateObject var viewModel = ViewModel()
    
    @State private static var mapScheme = NMAMapSchemeNormalDay

    var body: some View {
        VStack(spacing: 0.0) {
            // search field
            HStack {
                HStack {
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            
                            TextField("Caută...", text: $viewModel.currentAddressText)
                                .textFieldStyle(PlainTextFieldStyle())
                                .onTapGesture {
                                    self.viewModel.isEditingSearch = true
                                }
                        }
                        .padding(EdgeInsets(top: 9, leading: 13, bottom: 9, trailing: 13))
                        .foregroundColor(Color.regularText)
                    }
                    .background(Color.homeForeground)
                    .cornerRadius(8)
                    
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(Color.fieldBorder, lineWidth: 1)
                )

                if viewModel.isEditingSearch {
                    Button {
                        viewModel.isEditingSearch = false
                        hideKeyboard()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(20)
            .background(Color.homeBackground)

            ZStack {
                // map
                HEREMapsView(mapScheme: Self.$mapScheme)
                    .padding(.zero)
                    .environmentObject(viewModel.mapState)
                
                // save button
                VStack {
                    HStack {
                        Spacer()
                        
                        if viewModel.isLocating {
                            ProgressView()
                                .progressViewStyle(.circular)
                        }
                        
                        Button {
                            attemptToLocalizeUser()
                        } label: {
                            HStack {
                                Image.whiteMap
                                
                                Text("Localizează-mă")
                            }
                        }
                        .buttonStyle(LargeButton(bgColor: .accent, fgColor: .homeForeground))
                        .padding(.main)
                        .disabled(viewModel.isLocating)
                        .opacity(viewModel.isLocating ? 0.5 : 1)
                        
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Text("Salvează")
                            Image(systemName: "arrow.right")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(LargeButton(bgColor: .accent, fgColor: .homeForeground))
                    .padding(.main)
                    .disabled(!viewModel.canSave)
                }
                .padding(.bottom, 6)
                
                // search results
                if !viewModel.searchResults.isEmpty && viewModel.isEditingSearch {
                    List(viewModel.searchResults, id: \.address) { address in
                        AddressRow(location: address)
                            .onTapGesture {
                                viewModel.locationWasPickedFromList(address)
                                viewModel.isEditingSearch = false
                            }
                    }
                    .listStyle(PlainListStyle())
                    .padding(0)
                }
                
            }
            .padding(.zero)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .navigationTitle(viewModel.screenTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(false)
        .navigationBarItems(leading: Button(action: {
            // TODO:
        }, label: {
            Image(systemName: "xmark")
        }))
        .filledNavigationAppearance()
        .alert(isPresented: $viewModel.isError, content: {
            Alert(
                title: Text("Ups!"),
                message: Text(viewModel.currentErrorMessage ?? ""),
                dismissButton: .default(Text("Ok")))
        })
    }
    
    func attemptToLocalizeUser() {
        viewModel.detectUserLocation()
    }
}

#if DEBUG
struct AddressEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressEntryView()
        }
    }
}
#endif

struct AddressRow: View {
    let location: MapManager.MapLocation
    
    var body: some View {
        Text(location.address)
            .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
    }
}
