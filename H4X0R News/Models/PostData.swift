//
//  PostData.swift
//  H4X0R News
//
//  Created by Cory Carte on 5/14/22.
//

import Foundation

struct Post : Decodable, Identifiable {
    let id: Int
    let title: String
    let url: String?
    let score: Int
}
