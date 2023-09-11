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
            switch viewModel.loadingState {
            case .idle, .loading:
                LoadingView()
            case .loaded:
                VStack {
                    if let home = viewModel.home {
                        VStack {
                            List {
                                Section(header: Text("Home Details")) {
                                    Text("Home ID: \(home.homeId)")
                                    Text("Home Owner:  \(viewModel.homeOwner)")
                                    VStack(alignment: .leading) {
                                        Text("Home Name")
                                            .font(.caption)
                                        TextField("Enter a name for your home", text: $viewModel.homeName)
                                    }
                                    Button {
                                        viewModel.updateHomeName()
                                    } label: {
                                        Text("Update")
                                            .frame(height: 55)
                                            .frame(maxWidth: .infinity)
                                            .foregroundColor(Color("PrimaryText"))
                                            .background(Color("Highlight"))
                                            .cornerRadius(10)
                                            .padding(.horizontal)
                                    }
                                }
                                Section(header: Text("Home Members")) {
                                    ForEach(viewModel.homeMembers, id: \.self) { member in
                                        Text(member)
                                    }
                                }
                            }
                            Button {
                                viewModel.showAddMemberSheet.toggle()
                            } label: {
                                Text("Add A Home Member")
                                    .frame(height: 55)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(Color("PrimaryText"))
                                    .background(Color("Highlight"))
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                            }
                            Button {
                                viewModel.leaveHome()
                            } label: {
                                Text("Leave Home")
                                    .frame(height: 55)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(Color("PrimaryText"))
                                    .background(Color("ButtonBackgroundSecondary"))
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                            }
                            Spacer()
                        }
                        .sheet(isPresented: $viewModel.showAddMemberSheet) {
                            AddMemberView(viewModel: viewModel, homeId: home.homeId)
                        }
                        .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
                            Button("Ok", role: .cancel) { }
                        }
                    } else {
                        VStack(spacing: 25) {
                            Text("You are not part of a home!")
                                .font(.title)
                                .foregroundColor(Color("PrimaryText"))
                            Image(systemName: "house.lodge.fill")
                                .font(.title)
                                .foregroundColor(Color("PrimaryText"))
                            Button {
                                viewModel.createHome()
                            } label: {
                                Text("Create a Home")
                                    .frame(height: 55)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(Color("PrimaryText"))
                                    .background(Color("Highlight"))
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                            }
                            Button {
                                viewModel.showJoinHomeSheet.toggle()
                            } label: {
                                Text("Join a Home")
                                    .frame(height: 55)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(Color("PrimaryText"))
                                    .background(Color("ButtonBackgroundSecondary"))
                                    .cornerRadius(10)
                                    .padding(.horizontal)
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
                }
            case .error:
                MissingHomeView()
            }
        }
        .task {
            await viewModel.loadHome()
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
            Button("Ok", role: .cancel) { }
        }
        .navigationTitle("Home Profile")
    }
}

struct HomeProfileView_Previews: PreviewProvider {
    static var viewModel: HomeProfileViewModel = {
        let vm = HomeProfileViewModel()
        vm.home = HomeProfile(homeId: "xxxx", name: "Rickard Street", address: "44 Rickard Street Balgowlah", owner: "Cooper Jacob", members: [
            "Amelia Crawford",
            "Alex Jones",
            "Isa Yamada"
        ])
        vm.loadingState = .loaded
        return vm
    }()
    static var previews: some View {
        NavigationStack {
            HomeProfileView(viewModel: viewModel)
        }
        
    }
}
