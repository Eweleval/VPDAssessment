//
//  GItViewModel.swift
//  VPDAssessment
//
//  Created by Wellz Val on 3/15/25.
//

import Foundation

class RepositoryViewModel {
    var onDataChange: (() -> Void)?
    var onErrorChange: ((UserError) -> Void)?
    private var repositoryResource: GitProtocol?
    private var currentPage = 1
    private let itemsPerPage = 20
    var isLoadingMoreData = false
    var hasMoreData: Bool {
        return currentPage * itemsPerPage < repositoriesData.count
    }
    
    var repositoriesData: [Repositories] = [] {
        didSet {
            onDataChange?()
        }
    }
    var errorResponse: UserError = .unknownError() {
        didSet{
            onErrorChange?(errorResponse)
        }
    }
    
    init(repositoryResource: GitProtocol? = nil) {
        self.repositoryResource = repositoryResource
    }
    
    @MainActor
    func fetchRepositories() {
        guard let urlString = GitAPI.getRepositories.urlRequest.url?.absoluteString else { return }
        repositoryResource = GitResource(urlString: urlString)
        
        Task {
            do {
                guard let repositoryResource else { return }
                let repositories: [Repositories] = try await repositoryResource.fetchData()
                DispatchQueue.main.async {
                    self.repositoriesData = repositories
                    UserDefaults.standard.offLineRepo = repositories
                }
            } catch let error as UserError {
                DispatchQueue.main.async {
                    if self.errorResponse == .networkError() {
                        if let offLineRepo = UserDefaults.standard.offLineRepo {
                            self.repositoriesData = offLineRepo
                            return
                        }
                    } else {
                        self.errorResponse = error
                    }
                    
                }
            } catch let error as NSError {
                DispatchQueue.main.async {
                    self.errorResponse = .unknownError(error.localizedDescription)
                }
            }
        }
    }
    
    func getPaginatedData() -> [Repositories] {
        let startIndex = 0
        let endIndex = min(currentPage * itemsPerPage, repositoriesData.count)
        return Array(repositoriesData[startIndex..<endIndex])
    }
    
    func loadMoreData(completion: @escaping () -> Void) {
        guard hasMoreData, !isLoadingMoreData else { return }
        
        isLoadingMoreData = true
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            self.currentPage += 1
            self.isLoadingMoreData = false
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
}
