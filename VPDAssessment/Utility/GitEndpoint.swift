//
//  GitEndpoint.swift
//  VPDAssessment
//
//  Created by Wellz Val on 3/16/25.
//

import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest {get}
    var baseUrl: URL {get}
    var path: String {get}
}

enum GitAPI {
    case getRepositories
    case getUserDetails(String)
    case getUserRepos(String)
    case getUserCommits(String)
    case getCommitDetails(String)
}

extension GitAPI: APIBuilder {
    var urlRequest: URLRequest {
        let request = URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
        return request
    }
    
    var baseUrl: URL {
            return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .getRepositories:
            return "/repositories"
        case .getUserDetails(let username):
            return "/users/\(username)"
        case .getUserRepos(let username):
            return "/users/\(username)/repos"
        case .getUserCommits(let path):
            return "/repos/\(path)"
        case .getCommitDetails(let path):
            return "/repos/\(path)/commits"
        }
      
    }
}
