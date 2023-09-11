//
//  HomeProfileView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 11/9/2023.
//

import SwiftUI

struct HomeProfileView: View {
    
    @StateObject var viewModel = HomeProfileViewModel()
    
    var body: some View {
        ZStack {
            Color("ButtonBackground")
                .edgesIgnoringSafeArea(.all)
            VStack {
                List {
                    Section(header: Text("Home Details")) {
                        if let homeId = viewModel.homeId {
                            Text("\(homeId)")
                        } else {
                            Button {
                                viewModel.createHome()
                            } label: {
                                Text("Create a Home")
                                    .frame(height: 55)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(Color("PrimaryText"))
                                    .background(Color("Highlight"))
                                    .cornerRadius(10)
                            }
                            .listRowBackground(Color.clear)
                            Button {
                                viewModel.showJoinHomeSheet.toggle()
                            } label: {
                                Text("Join a Home")
                                    .frame(height: 55)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(Color("PrimaryText"))
                                    .background(Color("ButtonBackgroundSecondary"))
                                    .cornerRadius(10)
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        }
                    }
                }
            }
            .sheet(isPresented: $viewModel.showJoinHomeSheet) {
                VStack(alignment: .leading) {
                    Text("Home ID")
                        .font(.caption)
                    TextField("Enter Home ID", text: $viewModel.homeIdText)
                        .padding()
                    Button {
                        viewModel.joinHome()
                    } label: {
                        Text("Join Home")
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color("PrimaryText"))
                            .background(Color("Highlight"))
                            .cornerRadius(10)
                    }
                    Spacer()
                }
                .padding()
                .background(Color("ButtonBackground"))
                .edgesIgnoringSafeArea(.all)
                
            }
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
            Button("Ok", role: .cancel) { }
        }
        .navigationTitle("Home Profile")
    }
}

struct HomeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeProfileView()
        }
        
    }
}
