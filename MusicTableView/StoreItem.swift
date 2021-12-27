//
//  StoreItem.swift
//  MusicTableView
//
//  Created by 塗詠順 on 2021/12/24.
//

import Foundation

struct MusicResponse: Codable {
    let resultCount: Int
    let results: [StoreItem]
}

struct StoreItem: Codable {
    let artistName: String
    let collectionArtistName: String?
    let trackName: String
    let previewUrl: URL
    let artworkUrl100: URL
}
