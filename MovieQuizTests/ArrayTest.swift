//
//  ArrayTest.swift
//  MovieQuizTests
//
//  Created by Igor Ignatov on 16.03.2023.
//
import XCTest
@testable import MovieQuiz

final class ArrayTests: XCTestCase {
    func testGetValueInRange() throws {
        let array = [1, 2, 3, 4, 5]
        let value = array[safe: 2]
        
        XCTAssertNotNil(value)
        XCTAssertEqual(value, 2)
    }

    func testGetValueOutOfRange() throws {
        let array = [1, 2, 3, 4, 5]
        let value = array[safe: 20]
        
        XCTAssertNil(value)
    }
    
}
