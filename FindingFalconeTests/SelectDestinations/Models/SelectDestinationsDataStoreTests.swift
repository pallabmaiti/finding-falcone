//
//  SelectDestinationsDataStoreTests.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 15/03/24.
//

import XCTest
@testable import FindingFalcone

final class SelectDestinationsDataStoreTests: XCTestCase {
    func text_DataStore() {
        let dataStore = SelectDestinationsDataStore()
        
        XCTAssertTrue(dataStore.isLoading)
        XCTAssertEqual(dataStore.planetList, [])
        XCTAssertEqual(dataStore.vehicleList, [])
        XCTAssertNil(dataStore.token)
        
        dataStore.isLoading = false
        XCTAssertFalse(dataStore.isLoading)
        
        let planetList: [Planet] = [.mockAny()]
        dataStore.planetList = planetList
        
        XCTAssertEqual(dataStore.planetList, planetList)
        
        let vehicleList: [Vehicle] = [.mockAny()]
        dataStore.vehicleList = vehicleList
        
        XCTAssertEqual(dataStore.vehicleList, vehicleList)
        
        let token = Token(token: .mockAny())
        dataStore.token = token
        XCTAssertEqual(dataStore.token, token)
    }
}
