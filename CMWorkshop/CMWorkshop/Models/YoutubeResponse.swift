//
//  YoutubeResponse.swift
//  CMWorkshop
//
//  Created by Pongsakorn Praditkanok on 28/7/2563 BE.
//  Copyright © 2563 Ds42713. All rights reserved.
//

import Foundation

// MARK: - YoutubeResponse
struct YoutubeResponse: Codable {
    let youtubes: [Youtube]
    let error: Bool
    let errorMsg: String

    enum CodingKeys: String, CodingKey {
        case youtubes, error
        case errorMsg = "error_msg"
    }
}

// MARK: - Youtube
struct Youtube: Codable {
    let id, title, subtitle: String
    let avatarImage: String
    let youtubeImage: String

    enum CodingKeys: String, CodingKey {
        case id, title, subtitle
        case avatarImage = "avatar_image"
        case youtubeImage = "youtube_image"
    }
}
