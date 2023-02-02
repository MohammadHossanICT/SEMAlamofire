//
//  MockService.swift
//  Alomafire-ProjectTests
//
//  Created by M A Hossan on 31/01/2023.
//

import Foundation
@testable import Alomafire_Project

class MockService: NetworkManagerProtocol {

    var data: Data?
    
// Creating Mock

    func getModel<Model>(_ type: Model.Type, from url: String, completion: @escaping (Result<Model, Alomafire_Project.NetworkError>) -> ()) where Model : Decodable, Model : Encodable {

        if let data  = data {
            do  {
                let result = try JSONDecoder().decode(type, from: data)
                completion(.success(result))
            } catch (let error){
                print(error)

            }
        }
    }

}

