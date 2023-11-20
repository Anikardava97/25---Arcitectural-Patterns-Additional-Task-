//
//  API.swift
//  25 - Arcitectural Patterns (Additional Task)
//
//  Created by Ani's Mac on 18.11.23.
//

import UIKit

final class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://uselessfacts.jsph.pl/api/v2/facts/random"
    
    private init() {}
    
    func fetchFacts(completion: @escaping (Result<TodayFactsResponse, Error>) -> Void) {
        let urlStr = baseURL
        
        guard let url = URL(string: urlStr) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let factsResponses = try JSONDecoder().decode(TodayFactsResponse.self, from: data)
                completion(.success(factsResponses))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
