//
//  ContentTypesModel.swift
//  AvitoTestProject
//
//  Created by Alibek Ismagulov on 14.04.2024.
//

import Foundation


// Was trying to do proper enums and SF symbols to preview them on main screen
// Work in progress

public enum ContentTypes : String, Codable {
    
    case book = "book"
    case album = "album"
    case coachedAudio = "coached-audio"
    case featureMovie = "feature-movie"
    case interactiveBooklet = "interactive- booklet"
    case musicVideo = "music-video"
    case pdfPodcast = "pdf podcast"
    case podcastEpisode = "podcast-episode"
    case softwarePackage = "software-package"
    case song = "song"
    case tvEpisode = "tv- episode"
    case artist = "artist"
    case unknown = "unknown"

    enum CodingKeys: String, CodingKey, Codable {
        case book = "book.circle"
        case album = "photo.circle.fill"
        case coachedAudio = "waveform.circle.fill"
        case featureMovie = "movieclapper.fill"
        case interactiveBooklet = "book.pages.fill"
        case musicVideo = "video.circle"
        case pdfPodcast, podcastEpisode = "music.mic.circle.fill"
        case softwarePackage = "gearshape.fill"
        case song = "music.quarternote.3"
        case tvEpisode = "tv.fill"
        case artist = "person.fill"
        case unknown = "questionmark.app.fill"
        
    }
    
}
