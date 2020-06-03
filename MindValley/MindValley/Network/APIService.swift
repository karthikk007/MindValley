//
//  APIService.swift
//  MindValley
//
//  Created by Kumar, Karthik on 01/06/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import Foundation

class ApiService {
    static let sharedInstance = ApiService()
    
    let episodesUrl: String = "https://pastebin.com/raw/z5AExTtw"
    let categoriesUrl: String = "https://pastebin.com/raw/A0CgArX3"
    let channelsUrl: String = "https://pastebin.com/raw/Xt12uVhM"
    
    func fetchEpisodes(completion: @escaping (Episodes) -> ()) {
        fetch(for: episodesUrl, completion: completion)
//        fetchEpisodes(for: "\(episodesUrl)", completion: completion)
    }

    func fetchCategories(completion: @escaping (Categories) -> ()) {
        fetch(for: categoriesUrl, completion: completion)
//        fetchCategories(for: "\(categoriesUrl)", completion: completion)
    }

    func fetchChannels(completion: @escaping (Channels) -> ()) {
        fetch(for: channelsUrl, completion: completion)
//        fetchChannels(for: "\(channelsUrl)", completion: completion)
    }
    
    private func fetch<T>(for url: String, completion: @escaping (T) -> ()) where T: Decodable {
        let url = URL(string: url)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard error == nil else {
                print("error")
                return
            }
            
            guard let content = data else {
                print("no data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let json = try decoder.decode(T.self, from: content)
                
                //                print(json)
                
                DispatchQueue.main.async {
                    completion(json)
                }
                
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    private func fetchEpisodes(for url: String, completion: @escaping (Episodes) -> ()) {
        
        let url = URL(string: url)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in

            guard error == nil else {
                print("error")
                return
            }

            guard let content = data else {
                print("no data")
                return
            }

            do {
                let decoder = JSONDecoder()

                let json = try decoder.decode(Episodes.self, from: content)

//                print(json)

                DispatchQueue.main.async {
                    completion(json)
                }

            } catch let error {
                print(error)
            }

        }.resume()
    }
    
    private func fetchCategories(for url: String, completion: @escaping (Categories) -> ()) {
        
        let url = URL(string: url)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in

            guard error == nil else {
                print("error")
                return
            }

            guard let content = data else {
                print("no data")
                return
            }

            do {
                let decoder = JSONDecoder()

                let json = try decoder.decode(Categories.self, from: content)

//                print(json)

                DispatchQueue.main.async {
                    completion(json)
                }

            } catch let error {
                print(error)
            }

        }.resume()
    }
    
    private func fetchChannels(for url: String, completion: @escaping (Channels) -> ()) {
        fetch(for: url, completion: completion)
        
        let url = URL(string: url)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in

            guard error == nil else {
                print("error")
                return
            }

            guard let content = data else {
                print("no data")
                return
            }

            do {
                let decoder = JSONDecoder()

                let json = try decoder.decode(Channels.self, from: content)

//                print(json)

                DispatchQueue.main.async {
                    completion(json)
                }

            } catch let error {
                print(error)
            }

        }.resume()
    }
    
}
