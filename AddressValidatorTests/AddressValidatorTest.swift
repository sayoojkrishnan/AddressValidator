//
//  AddressValidatorTest.swift
//  AddressValidatorTests
//
//  Created by Sayooj Krishnan  on 02/08/21.
//

@testable import AddressValidator
import XCTest

class AddressValidatorTests : XCTestCase {
    
    var sut : AddressValidator!
    var delegate = MockAddressDelegate()
    
    override func setUpWithError() throws {
        sut = AddressValidator()
        sut.delegate = delegate
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testAddressValidator_WhenValidStreetProvided_ShouldMarkisStreetAddressValidAsTrue() {
        sut.streetAddress = "5071 Salerno St"
        XCTAssertTrue(sut.isStreetAddressValid)
        sut.streetAddress = "5071 Salerno Avenue"
        XCTAssertTrue(sut.isStreetAddressValid)
    }
    
    func testAddressValidator_WhenInvalidStreetProvided_ShouldMarkisStreetAddressValidAsFalse() {
        sut.streetAddress = "5071 Salerno St,"
        XCTAssertFalse(sut.isStreetAddressValid)
        sut.streetAddress = "5071 Salerno"
        XCTAssertFalse(sut.isStreetAddressValid)
    }
    
    func testAddressValidator_WhenValidCityProvided_ShouldMarkisCityValidAsTrue() {
        sut.city = "Miami"
        XCTAssertTrue(sut.isCityValid)
    }
    
    func testAddressValidator_WhenInvalidCityProvided_ShouldMarkisCityValidFalse() {
        sut.city = "Miami123"
        XCTAssertFalse(sut.isCityValid)
        sut.city = "Mi,"
        XCTAssertFalse(sut.isCityValid)
    }
    
    func testAddressValidator_WhenValidStateProvided_ShouldMarkisStateValidTrue() {
        sut.state = "FL"
        XCTAssertTrue(sut.isStateValid)
    }
    
    func testAddressValidator_WhenInvalidStateProvided_ShouldMarkisStateValidFalse() {
        sut.state = "Florida"
        XCTAssertFalse(sut.isStateValid)
        sut.state = "fl"
        XCTAssertFalse(sut.isStateValid)
    }
    
    func testAddressValidator_WhenValidZipProvided_ShouldMarkzipCodeTrue() {
        sut.zipCode = "11111-2121"
        XCTAssertTrue(sut.isZipValid)
        sut.zipCode = "11111"
        XCTAssertTrue(sut.isZipValid)
    }
    
    func testAddressValidator_WhenInvalidZipProvided_ShouldMarkzipCodeFalse() {
        sut.zipCode = "11111-212"
        XCTAssertFalse(sut.isZipValid)
        sut.zipCode = "1111"
        XCTAssertFalse(sut.isZipValid)
    }
    
    func testAddressValidator_WhenAllFieldsAreValid_ShouldMarkisFormValidTrue() {
        sut.streetAddress = "5071 Salerno St"
        sut.city = "Miami"
        sut.state = "FL"
        sut.zipCode = "33326-3432"
        XCTAssertTrue(sut.isFormValid)
    }
    
    func testAddressValidator_WhenAllFieldsAreValid_DelegatShouldCalled() {
        sut.streetAddress = "5071 Salerno St"
        sut.city = "Miami"
        sut.state = "FL"
        sut.zipCode = "33326-3432"
        XCTAssertTrue(delegate.receivedState)
        XCTAssertTrue(delegate.calledDelegate)
    }
    
}

class MockAddressDelegate : AddressValidatorDelegate {
    
    var calledDelegate : Bool = false
    var receivedState : Bool = false
    
    func formStateDidChange(toState isValid: Bool, validator: AddressValidator) {
        receivedState = isValid
        calledDelegate = true
    }
    
}
