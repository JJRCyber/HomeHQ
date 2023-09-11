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
    
    // Shows sheet to join a new home
    @Published var showJoinHomeSheet: Bool = false
    @Published var showAddMemberSheet: Bool = false
    @Published var showQRScannerSheet: Bool = false
    // Bound to text field in displayed
    @Published var homeIdText: String = ""
    
    @Published var homeOwner: String = ""
    @Published var homeMembers: [String] = []
    
    func loadHome() async {
        if let homeId {
            loadingState = .loading
            do {
                self.home = try await dataStore.homeManager.getHome(homeId: homeId)
                loadingState = .loaded
                if self.home != nil {
                    getHomeOwner()
                    getHomeMembers()
                    loadValues()
                }
            } catch {
                showError = true
                errorMessage = error.localizedDescription
                loadingState = .error
            }
        } else {
            loadingState = .loaded
        }

    }
    
    func loadValues() {
        guard let home else { return }
        homeName = home.name
        address = home.address ?? ""
    }
    
    func joinHome(homeId: String) {
        guard let userId else {
            showError = true
            errorMessage = "User could not be retrieved"
            return
        }
        
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
    
    // Creates a new home with some default values
    func createHome() {
        guard let userId else {
            showError = true
            errorMessage = "User could not be retrieved"
            return
        }
        let members = [userId]
        let home = HomeProfile(name: homeName, address: address, owner: userId, members: members)
        Task {
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
    
    func getHomeOwner() {
        guard let home else { return }
        Task {
            let owner = try await dataStore.userManager.getUser(userId: home.owner)
            self.homeOwner = owner.name ?? owner.userId
        }
    }
    
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
