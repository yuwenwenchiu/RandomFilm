//
//  Film.swift
//  RandomFilm
//
//  Created by Yuwen Chiu on 2019/8/30.
//  Copyright © 2019 YuwenChiu. All rights reserved.
//

import Foundation

struct Film {
    var filmName: String?
    var filmImage: String?
    var director: String?
    var genre: String?
    var releaseDate: String?
}

struct AllData: Codable {
    var feed: SingleData?
}

struct SingleData: Codable {
    var results: [FilmInfo]?
}

struct FilmInfo: Codable {
    var artistName: String?
    var releaseDate: String?
    var name: String?
    var artworkUrl100: String?
    var genres: [Genres]?
}

struct Genres: Codable {
    var name: String?
}
