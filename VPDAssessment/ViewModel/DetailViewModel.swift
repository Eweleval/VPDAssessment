//
//  DetailsViewModel.swift
//  VPDAssessment
//
//  Created by Wellz Val on 3/15/25.
//

import Foundation

class DetailsViewModel {
    var onDataChange: (() -> Void)?
    var onErrorChange: ((UserError) -> Void)?
    private var detailsResource: GitProtocol?
    var username: String? = ""
    var detailsData: UserDetails = UserDetails.dummyData {
        didSet {
            onDataChange?()
        }
    }
    var reposData: [Repositories] = [] {
        didSet {
            onDataChange?()
        }
    }
    var error: UserError = .unknownError() {
        didSet{
            onErrorChange?(error)
        }
    }
    
    init(detailsResource: GitProtocol? = nil) {
        self.detailsResource = detailsResource
    }
    
    @MainActor
    func fetchUserDetails() {
        guard let urlString = GitAPI.getUserDetails(username ?? "").urlRequest.url?.absoluteString else { return }
        detailsResource = GitResource(urlString: urlString)
        
        Task {
            do {
                guard let detailsResource else { return }
                let details : UserDetails = try await detailsResource.fetchData()
                DispatchQueue.main.async {
                    self.detailsData = details
                    self.fetchUserRepo()
                }
            } catch let error as UserError {
                DispatchQueue.main.async {
                    self.error = error
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = .unknownError(error.localizedDescription)
                }
            }
        }
    }
    
    @MainActor
    func fetchUserRepo() {
        guard let urlString = GitAPI.getUserRepos(username ?? "").urlRequest.url?.absoluteString else { return }
        detailsResource = GitResource(urlString: urlString)
        
        Task {
            do {
                guard let detailsResource else { return }
                let details : [Repositories] = try await detailsResource.fetchData()
                DispatchQueue.main.async {
                    self.reposData = details
                }
            } catch let error as UserError {
                DispatchQueue.main.async {
                    self.error = error
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = .unknownError(error.localizedDescription)
                }
            }
        }
    }
}
