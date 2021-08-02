//
//  AddressValidator.swift
//  AddressValidator
//
//  Created by Sayooj Krishnan  on 02/08/21.
//

import Foundation

protocol AddressValidatorDelegate : AnyObject {
    func formStateDidChange(toState isValid: Bool , validator : AddressValidator )
}

final class AddressValidator {
    
    private let streetRegex = #"^\d{1,6}\040([A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,})$|^\d{1,6}\040([A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,})$|^\d{1,6}\040([A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,})$"#
    
    private let cityRegex = #"^[a-zA-Z]+(?:[\s-][a-zA-Z]+)*$"#
    private let stateRegex = #"[^,]*[A-Z]{2}"#
    private let zipRegex = #"^\d{5}(?:[-\s]\d{4})?$"#
    
    weak var delegate : AddressValidatorDelegate?
    
    
    var isFormValid : Bool {
        return isStreetAddressValid && isCityValid && isStateValid && isZipValid
    }
    
    private(set) var isStreetAddressValid  = false
    private(set) var isCityValid = false
    private(set) var isStateValid = false
    private(set) var isZipValid = false
    
    var streetAddress : String = "" {
        didSet {
            isStreetAddressValid =  validate(input: streetAddress, regex: streetRegex)
            delegate?.formStateDidChange(toState: isFormValid, validator: self)
        }
    }
    
    var state : String = "" {
        didSet {
            isStateValid = validate(input: state, regex: stateRegex)
            delegate?.formStateDidChange(toState: isFormValid, validator: self)
        }
    }
    
    var city : String = "" {
        didSet {
            isCityValid =  validate(input: city, regex: cityRegex)
            delegate?.formStateDidChange(toState: isFormValid, validator: self)
        }
    }
    
    var zipCode : String = ""{
        didSet {
            isZipValid = validate(input: zipCode, regex: zipRegex)
            delegate?.formStateDidChange(toState: isFormValid, validator: self)
        }
    }
    
    
    private func validate(input : String , regex : String ) -> Bool {
        let validator = NSPredicate(format:"SELF MATCHES %@", regex)
        return validator.evaluate(with: input)
    }
    
}
