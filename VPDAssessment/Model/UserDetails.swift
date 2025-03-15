//
//  UserDetails.swift
//  VPDAssessment
//
//  Created by Wellz Val on 3/15/25.
//

import Foundation


// MARK: - Welcome
//struct UserDetails: Codable, Identifiable {
//    let login: String?
//    let id: Int?
//    let avatarURL: String?
//    let name: String?
//    let location: String?
//    let email, bio: String?
//
//    enum CodingKeys: String, CodingKey {
//        case login, id
//        case avatarURL = "avatar_url"
//       
//        case name, email,  bio, location
//       
//    }
//}

struct UserDetails: Codable, Identifiable {
    let login: String?
    let id: Int?
    let nodeID: String?
    let avatarURL: String?
    let gravatarID: String?
    let url, htmlURL, followersURL: String?
    let followingURL, gistsURL, starredURL: String?
    let subscriptionsURL, organizationsURL, reposURL: String?
    let eventsURL: String?
    let receivedEventsURL: String?
    let type, userViewType: String?
    let siteAdmin, hireable: Bool?
    let name, company: String?
    let blog: String?
    let location: String?
    let email,  bio: String?
    let twitterUsername: String?
    let publicRepos, publicGists, followers, following: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case userViewType = "user_view_type"
        case siteAdmin = "site_admin"
        case name, company, blog, location, email, hireable, bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

typealias UserDetailsArray = [UserDetails]

extension UserDetails {
    
   static var dummyData: UserDetails {
       .init(login: "", id: 0, nodeID: "", avatarURL: "", gravatarID: "", url: "", htmlURL: "", followersURL: "", followingURL: "", gistsURL: "", starredURL: "", subscriptionsURL: "", organizationsURL: "", reposURL: "", eventsURL: "", receivedEventsURL: "", type: "", userViewType: "", siteAdmin: false, hireable: false, name: "", company: "", blog: "", location: "", email: "",  bio: "", twitterUsername: "", publicRepos: 0, publicGists: 0, followers: 0, following: 0,
             createdAt: "", updatedAt: ""
       )
    }
}
