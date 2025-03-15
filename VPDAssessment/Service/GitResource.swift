//
//  GitResource.swift
//  VPDAssessment
//
//  Created by Wellz Val on 3/16/25.
//

import Foundation

protocol GitProtocol {
    func fetchData<T: Decodable>() async throws -> T
}

struct GitResource: GitProtocol {
    private var gitUtility: GitService
    private var urlString: String

    init(gitUtility: GitService = GitUtility(), urlString: String) {
        self.gitUtility = gitUtility
        self.urlString = urlString
    }

    func fetchData<T: Decodable>() async throws -> T {
        guard let url = URL(string: urlString) else {
            throw UserError.invalidURL()
        }
        
        let data: T = try await gitUtility.performDataTask(url: url, resultType: T.self)
        return data
    }
}
