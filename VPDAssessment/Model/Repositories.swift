//
//  repositories.swift
//  VPDAssessment
//
//  Created by Wellz Val on 3/15/25.
//

import Foundation


// MARK: - WelcomeElement
struct Repositories: Codable , Identifiable {
    let id: Int?
    let nodeID, name, fullName: String?
    let welcomePrivate: Bool?
    let owner: Owner?
    let description: String?
    let fork: Bool?
    let url, forksURL: String?

    let commitsURL, gitCommitsURL, reposURL: String?


    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case welcomePrivate = "private"
        case owner

        case description, fork, url
        case forksURL = "forks_url"
        case commitsURL = "commits_url"
        case reposURL = "repos_url"
        case gitCommitsURL = "git_commits_url"
    
    }
}

// MARK: - Owner
struct Owner: Codable {
    let login: String?
    let id: Int?
    let avatarURL: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case login, id, url
        case avatarURL = "avatar_url"
    }
}

enum TypeEnum: String, Codable {
    case organization = "Organization"
    case user = "User"
}

typealias GitResponse = [Repositories]

extension Repositories {
    
    static var dummyData: Repositories {
        .init(id: 1, nodeID: "", name: "", fullName: "", welcomePrivate: true, owner: Owner(login: "", id: 1, avatarURL: "", url: ""), description: "", fork: true, url: "", forksURL: "", commitsURL: "", gitCommitsURL: "", reposURL: "")
    }
}
