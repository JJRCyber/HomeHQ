//
//  HomeProfileViewModel.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 11/9/2023.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import CodeScanner

@MainActor
final class HomeProfileViewModel: BaseViewModel {
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    @Published var home: HomeProfile? = nil
    
    @Published var homeName: String = ""
    @Published var address: String = ""
    
    // Shows different sheets based on button press
    @Published var showJoinHomeSheet: Bool = false
    @Published var showAddMemberSheet: Bool = false
    @Published var showQRScannerSheet: Bool = false
    
    // Bound to text field in displayed
    @Published var homeIdText: String = ""
    @Published var homeOwner: String = ""
    @Published var homeMembers: [String] = []
    
    // Loads the home document from Firestore
    func loadHome() async {
        // Checks if homeId has been set in UserDefaults
        if let homeId {
            loadingState = .loading
            do {
                self.home = try await dataStore.homeManager.getHome(homeId: homeId)
                loadingState = .loaded
                if self.home != nil {
                    // Once home is loaded load all values from document
                    loadValues()
                }
            } catch {
                // Display error message if can't load home
                showError = true
                errorMessage = error.localizedDescription
                loadingState = .error
            }
        } else {
            // Set loading state to loaded if no homeId
            // This indicates the user has not joined a home
            loadingState = .loaded
        }

    }
    
    // Loads values once the home has been loaded
    func loadValues() {
        guard let home else { return }
        homeName = home.name
        address = home.address ?? ""
        getHomeOwner()
        getHomeMembers()
    }
    
    // Joins a home when given a homeID from QR code scanning
    func joinHome(homeId: String) {
        // Checks that userId has been set in UserDefaults
        // This should never be nil as it is set everytime a user logs in
        guard let userId else {
            showError = true
            errorMessage = "User could not be retrieved"
            return
        }
        
        // Adds user to home document and updates users homeId in Firestore
        Task {
            do {
                try await dataStore.homeManager.addHomeMember(homeId: homeId, userId: userId)
                try await dataStore.userManager.updateHomeId(userId: userId, homeId: homeId)
                self.homeId = homeId
                self.home = try await dataStore.homeManager.getHome(homeId: homeId)
                await loadHome()
            } catch {
                showError = true
                errorMessage = "Could not add user to home"
            }
        }
    }
    
    // Updates home name in Firestore
    func updateHomeName() {
        guard let home else { return }
        Task {
            do {
                try await dataStore.homeManager.updateHomeName(homeId: home.homeId, homeName: homeName)
            } catch {
                showError = true
                errorMessage = error.localizedDescription
            }
        }
    }
    
    // Creates a new home
    func createHome() {
        // Checks that userId has been set in UserDefaults
        // This should never be nil as it is set everytime a user logs in
        guard let userId else {
            showError = true
            errorMessage = "User could not be retrieved"
            return
        }
        
        // Sets up home with default values
        let members = [userId]
        let home = HomeProfile(name: homeName, address: address, owner: userId, members: members)
        Task {
            // Creates home document in Firestore and updates viewModel
            do {
                try await dataStore.homeManager.createNewHome(home: home)
                try await dataStore.userManager.updateHomeId(userId: userId, homeId: home.homeId)
                self.home = try await dataStore.homeManager.getHome(homeId: home.homeId)
            } catch {
                showError = true
                errorMessage = "Failed to create home"
            }
        }
    }
    
    // Function to handle QR scan which returns the homeId
    // Uses an external library for QR scanning
    func handleQRScan(result: Result<ScanResult, ScanError>) {
        showQRScannerSheet.toggle()
        switch result {
        case .success(let result):
            let homeId = result.string
            joinHome(homeId: homeId)
        case .failure(let error):
            showError = true
            errorMessage = error.localizedDescription
        }
    }
    
    // Rerieves home owner name from Firestore
    // Only userId is in owner property so a seperate lookup needs
    // to be done to get name property, defaults to userId if no name set
    func getHomeOwner() {
        guard let home else { return }
        Task {
            let owner = try await dataStore.userManager.getUser(userId: home.owner)
            self.homeOwner = owner.name ?? owner.userId
        }
    }
    
    // Rerieves home member names from Firestore
    // Only userId is in member array so a seperate lookup needs
    // to be done to get name property, defaults to userId if no name set
    func getHomeMembers() {
        guard let home else { return }
        Task {
            var homeMembers: [String] = []
            for member in home.members {
                let user = try await dataStore.userManager.getUser(userId: member)
                let name = user.name ?? user.userId
                homeMembers.append(name)
            }
            self.homeMembers = homeMembers
        }
    }
    
    // Leaves the current home and resets all viewModel values
    func leaveHome() {
        guard let home else { return }
        guard let userId else { return }
        Task {
            do {
                self.home = nil
                self.homeId = nil
                try await dataStore.homeManager.removeHomeMember(homeId: home.homeId, userId: userId)
                await loadHome()
            } catch {
                showError = true
                errorMessage = error.localizedDescription
            }

        }
       
    }
    
    // Generates QR code from homeId to display on addMember sheet
    func generateQRCode(homeId: String) -> UIImage {
        filter.message = Data(homeId.utf8)
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
