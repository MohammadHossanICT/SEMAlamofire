//
//  Alomafire_ProjectTests.swift
//  Alomafire-ProjectTests
//
//  Created by M A Hossan on 31/01/2023.
//

import XCTest
@testable import Alomafire_Project
import Combine

final class Alomafire_ProjectTests: XCTestCase {

    private var viewModel: ViewModel?
    private var subscribers = Set<AnyCancellable>()
    private var mockService = MockService()

    override func setUpWithError() throws {
        viewModel = ViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testTotalCount() throws {
        // Given
        mockService.data = try getData(json: "SchoolSuccessResponse")
        var schools: [School] = []
        let expectation = expectation(description: "waiting for response")

        // When
        viewModel?
            .$school
            .dropFirst()
            .sink(receiveValue: { result in
                schools = result
                expectation.fulfill()
            })
            .store(in: &subscribers)
        viewModel?.getSchools()

        // Then
        waitForExpectations(timeout: 5.0)
        XCTAssertFalse(schools.isEmpty)
        XCTAssertTrue(schools.count == 440)

    }

    func testFirstSchoolName() throws {

        // Given
        mockService.data = try getData(json: "SchoolSuccessResponse")
        var schools: [School] = []
        let expectation = expectation(description: "waiting for response")

        // When
        viewModel?
            .$school
            .dropFirst()
            .sink(receiveValue: { result in
                schools = result
                expectation.fulfill()
            })
            .store(in: &subscribers)
        viewModel?.getSchools()

        // Then
        waitForExpectations(timeout: 5.0)
        XCTAssertEqual(schools.first?.schoolName, "Clinton School Writers & Artists, M.S. 260" ,"Invalid School Name")

    }


    func testFirstLocation() throws {

        // Given
        mockService.data = try getData(json: "SchoolSuccessResponse")
        var schools: [School] = []
        let expectation = expectation(description: "waiting for response")

        // When
        viewModel?
            .$school
            .dropFirst()
            .sink(receiveValue: { result in
                schools = result
                expectation.fulfill()
            })
            .store(in: &subscribers)
        viewModel?.getSchools()

        // Then
        waitForExpectations(timeout: 5.0)
        XCTAssertEqual(schools.first?.location, "10 East 15th Street, Manhattan NY 10003 (40.736526, -73.992727)", "Invalid Location Name")

    }

    func getData(json: String) throws -> Data {
        guard let url = Bundle(for: Alomafire_ProjectTests.self).url(forResource: json, withExtension: "json")
        else { return Data() }
        return try Data(contentsOf: url)
    }
}

