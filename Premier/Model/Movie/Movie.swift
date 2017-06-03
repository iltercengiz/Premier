//
//  Movie.swift
//  Premier
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import Foundation
import ObjectMapper

struct Movie: Mappable {
    
    var id: Int!
    var posterURL: URL?
    var title: String!
    var overview: String = ""
    var releaseDate: Date?
    var genreIDs: [Int]?
    var originalTitle: String?
    var originalLanguage: String?
    var backdropPath: URL?
    var popularity: Double?
    var voteCount: Int?
    var voteAverage: Double?
    var isAdult: Bool = false
    var isVideo: Bool = false
    
    // MARK: - Mappable
    
    init?(map: Map) {
        guard map.JSON["id"] != nil,
              map.JSON["title"] != nil
        else {
            // Don't even create a movie object that doesn't have
            // an id and a title.
            return nil
        }
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        posterURL <- (map["poster_path"], ImageURLTransform())
        title <- map["title"]
        overview <- map["overview"]
        releaseDate <- (map["release_date"], DateTransform())
        genreIDs <- map["genre_ids"]
        originalTitle <- map["original_title"]
        originalLanguage <- map["original_language"]
        backdropPath <- (map["backdrop_path"], ImageURLTransform())
        popularity <- map["popularity"]
        voteCount <- map["vote_count"]
        voteAverage <- map["vote_average"]
        isAdult <- map["adult"]
        isVideo <- map["video"]
    }
    
}

/**
 * A sample JSON of this resource
{
    "poster_path": "\/xq1Ugd62d23K2knRUx6xxuALTZB.jpg",
    "adult": false,
    "overview": "Two strangers find themselves linked in a bizarre way. When a connection forms, will distance be the only thing to keep them apart?",
    "release_date": "2016-08-26",
    "genre_ids": [
      16,
      18,
      14,
      10749
    ],
    "id": 372058,
    "original_title": "君の名は。",
    "original_language": "ja",
    "title": "Your Name.",
    "backdrop_path": "\/7OMAfDJikBxItZBIug0NJig5DHD.jpg",
    "popularity": 6.646871,
    "vote_count": 211,
    "video": false,
    "vote_average": 8.5
}
 */
