//
//  NetworkManager.swift
//  Alomafire-Project
//
//  Created by M A Hossan on 31/01/2023.
//

import Foundation
import Alamofire

 protocol NetworkManagerProtocol {
     
     // Creating Generic Model
    func getModel<Model: Codable>(_ type: Model.Type, from url: String, completion: @escaping (Result<Model, NetworkError>) -> ())
}


class NetworkManager: NetworkManagerProtocol  {

    // Using Alamofire for making API call

    func getModel<Model: Codable>(_ type: Model.Type, from url: String, completion: @escaping (Result<Model, NetworkError>) -> ()) {

        guard let url = URL(string: url) else {
            completion(.failure(.badURL))
            return
        }

        AF.request(url).responseData { response in
            if let data = response.data {
                do {
                    let response = try JSONDecoder().decode(type, from: data)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(.other(error)))
                }
            }
        }

    }
}
