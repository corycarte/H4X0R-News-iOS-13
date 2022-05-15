//
//  NetworkManager.swift
//  H4X0R News
//
//  Created by Cory Carte on 5/14/22.
//

import Foundation
import SwiftUI

class NetworkManger: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchPost(id: Int) {
        if let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json?print=pretty") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, reponse, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let r = try decoder.decode(Post.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts.append(r)
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func fetchData() {
        if let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode([Int].self, from: safeData)
                            for r in results[...20] {
                                self.fetchPost(id: r)
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
