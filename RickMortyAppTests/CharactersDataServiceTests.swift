//
//  RickMortyAppTests.swift
//  RickMortyAppTests
//
//  Created by Rana Mahmoud on 04/12/2024.
//

import XCTest
import Combine
@testable import RickMortyApp

final class CharactersDataServiceTests: XCTestCase {
    
    var dataService: CharactersDataService!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        dataService = CharactersDataService()
        cancellables = []
    }

    override func tearDownWithError() throws {
        dataService = nil
        cancellables = nil
    }

    func testGetCharactersSuccess() {
        let mockResponse = CharacterResponseModel(
            pageInfo: PageInfoModel(totalCount: 2, totalPages: 1, nextPageURL: "", previousPageURL: ""),
            characters: [
                CharacterModel(
                    id: 361,
                    name: "Toxic Rick",
                    status: .dead,
                    species: "Humanoid",
                    type: "Rick's toxic side",
                    gender: .male,
                    imageURL: "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
                    origin: LocationModel(name: "Detoxifier", url: "https://rickandmortyapi.com/api/location/64"),
                    currentLocation: LocationModel(name: "Earth (Replacement Dimension)", url: "https://rickandmortyapi.com/api/location/20"),
                    episodeURLs: ["https://rickandmortyapi.com/api/episode/27"],
                    detailsURL: "https://rickandmortyapi.com/api/character/361",
                    creationDate: "2018-01-10T18:20:41.703Z"
                ),
                CharacterModel(
                    id: 362,
                    name: "Traflorkian",
                    status: .alive,
                    species: "Alien",
                    type: "Traflorkian",
                    gender: .unknown,
                    imageURL: "https://rickandmortyapi.com/api/character/avatar/362.jpeg",
                    origin: LocationModel(name: "unknown", url: ""),
                    currentLocation: LocationModel(name: "Worldender's lair", url: "https://rickandmortyapi.com/api/location/4"),
                    episodeURLs: [
                        "https://rickandmortyapi.com/api/episode/11",
                        "https://rickandmortyapi.com/api/episode/13"
                    ],
                    detailsURL: "https://rickandmortyapi.com/api/character/362",
                    creationDate: "2018-01-10T18:52:08.927Z"
                )
            ]
        )

        MockNetworkingManager.mockResult = .success(mockResponse)

        let expectation = XCTestExpectation(description: "Characters fetched successfully")
        
        dataService.getCharacters(pageNumber: 1)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but got failure")
                }
            }, receiveValue: { response in
                XCTAssertEqual(response.characters.count, 20)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }

}
