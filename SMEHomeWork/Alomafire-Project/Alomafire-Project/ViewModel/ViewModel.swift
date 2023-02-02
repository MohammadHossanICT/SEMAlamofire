//
//  ViewModel.swift
//  Alomafire-Project
//
//  Created by M A Hossan on 31/01/2023.
//

import Foundation
import Combine

class ViewModel {

    private let networkManager = NetworkManager()
    @Published private(set) var school = [School]()


    func getSchools() {
        loadMoreSchools()
    }

    func loadMoreSchools() {

        let newURL = NetworkURLs.baseURL

        // Creatig the API into View Model by using Combine 
        networkManager
            .getModel([School].self, from: newURL) { [weak self] result in

                switch result {
                case .success(let schoolResponse):
                    self?.school = schoolResponse
                    print(schoolResponse)
                case .failure(let error):
                    print(error)
                }
            }
    }

    func getSchoolName(by row: Int) -> String {
        let schoolName = school[row]
        return schoolName.schoolName.uppercased()
    }

    func getSchoolLocation(by row: Int) -> String {
        return "\(school[row].location)"
    }

}

