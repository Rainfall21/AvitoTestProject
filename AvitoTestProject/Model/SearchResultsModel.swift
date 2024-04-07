//
//  SearchResultsModel.swift
//  AvitoTestProject
//
//  Created by Alibek Ismagulov on 08.04.2024.
//

import Foundation
import UIKit

//Codable Struct for default query
struct SearchResultsModel : Codable {
    
    let results : [SearchItems]

}

struct SearchItems : Codable {
    
    var type : String?
    var kind : String?
    var author : String?
    var poster : String?
    var description : String?
    var length : Int?
    var price : Double?
    var genre : String?
    var rating : String?
    var url : URL?
    var authorID : Int?
    var name: String?
    var backUpName : String?
    var downloadedPoster : UIImage? = UIImage(systemName: "person.slash.fill")
    var authorURL : String? {
        if let id = authorID {
            return "https://itunes.apple.com/lookup?id=\(id)"
        } else {
            return nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case type = "wrapperType"
        case kind = "kind"
        case author = "artistName"
        case poster = "artworkUrl100"
        case description = "longDescription"
        case length = "trackTimeMillis"
        case price = "trackPrice"
        case genre = "primaryGenreType"
        case rating = "contentAdvisoryRating"
        case url = "trackViewURL"
        case authorID = "artistId"
        case name = "trackName"
        case backUpName = "collectionName"
    }
}

//Codable struct for lookup query

struct AuthorResultsModel : Codable {
    
    let results : [Author]

}

struct Author : Codable {
    var artistType : String?
    var primaryGenreName : String?
    
    enum CodingKeys: String, CodingKey {
        case artistType = "artistType"
        case primaryGenreName = "primaryGenreName"
    }
}
