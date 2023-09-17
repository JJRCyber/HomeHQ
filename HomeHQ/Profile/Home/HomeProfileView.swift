//
//  HomeProfileView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 11/9/2023.
//

import SwiftUI
import CodeScanner

struct HomeProfileView: View {
    
    @StateObject var viewModel = HomeProfileViewModel()
    
    // MARK: View
    // Home profile view displays information about home and members
    var body: some View {
        ZStack {
            Color("ButtonBackground")
                .edgesIgnoringSafeArea(.all)
            
            // View switches based on loading state
            switch viewModel.loadingState {
            case .idle, .loading:
                LoadingView()
            case .loaded:
                VStack {
                    if let home = viewModel.home {
                        VStack {
                            List {
                                // Section contains home details values
                                // Only home name can be updated
                                Section(header: Text("Home Details")) {
                                    Text("Home ID: \(home.homeId)")
                                    Text("Home Owner:  \(viewModel.homeOwner)")
                                    VStack(alignment: .leading) {
                                        Text("Home Name")
                                            .font(.caption)
                                        TextField("Enter a name for your home", text: $viewModel.homeName)
                                    }
                                    updateHomeNameButton
                                        .listRowSeparator(.hidden)
                                }
                                .listRowBackground(Color.clear)
                                
                                // Loops over and displays all members in home
                                Section(header: Text("Home Members")) {
                                    ForEach(viewModel.homeMembers, id: \.self) { member in
                                        Text(member)

                                    }
                                }
                                .listRowBackground(Color.clear)
                            }
                            .listStyle(.plain)
                            showAddMemberSheetButton
                            leaveHomeButton
                            Spacer()
                        }
                        
                        // Displays a sheet view with a QR code that someone can scan to be added to home
                        .sheet(isPresented: $viewModel.showAddMemberSheet) {
                            AddMemberView(viewModel: viewModel, homeId: home.homeId)
                        }
                        
                    } else {
                        
                        // Alternate view that is displayed if user has not joined a home
                        VStack(spacing: 25) {
                            noHomeTitle
                            createHomeButton
                            joinHomeButton
                        }
                    }
                }
                .ignoresSafeArea(.keyboard)
                
                // Displays QR scanner view when joinHomeButton pressed
                .sheet(isPresented: $viewModel.showQRScannerSheet) {
                    QRScanView(completion: viewModel.handleQRScan)
                }
            case .error:
                MissingHomeView()
            }
        }
        .task {
            await viewModel.loadData()
        }
        
        // Displays pop up alert if any functions throw errors
        .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
            Button("Ok", role: .cancel) { }
        }
        .navigationTitle("Home Profile")
    }
    
    //MARK: View Components
    // Various view components below
    var showAddMemberSheetButton: some View {
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
    }
    
    var leaveHomeButton: some View {
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
    }
    
    var updateHomeNameButton: some View {
        Button {
            viewModel.updateHomeName()
        } label: {
            Text("Update Home Name")
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color("PrimaryText"))
                .background(Color("Highlight"))
                .cornerRadius(10)
                .padding(.horizontal)
        }
    }
    
    var noHomeTitle: some View {
        VStack {
            Text("You are not part of a home!")
                .font(.title)
                .foregroundColor(Color("PrimaryText"))
            Image(systemName: "house.lodge.fill")
                .font(.title)
                .foregroundColor(Color("PrimaryText"))
        }
    }
    
    var createHomeButton: some View {
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
    }
    
    var joinHomeButton: some View {
        Button {
            viewModel.showQRScannerSheet.toggle()
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
