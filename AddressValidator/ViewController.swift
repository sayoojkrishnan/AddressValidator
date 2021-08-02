//
//  ViewController.swift
//  AddressValidator
//
//  Created by Sayooj Krishnan  on 02/08/21.
//

import UIKit

class ViewController: UIViewController,AddressValidatorDelegate {
    
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var streetAddress: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    
    let validator : AddressValidator = AddressValidator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validator.delegate = self
        proceedButton.isEnabled = false
        _ = [streetAddress,state,city,zipCode].map({$0?.addTarget(self, action: #selector(handleTextChnage(forTextField:)), for: .editingChanged)})
    }
    
    func formStateDidChange(toState isValid : Bool, validator: AddressValidator) {
        proceedButton.isEnabled = isValid
    }
    
    @IBAction func didTapPorceedButton(_ sender: UIButton) {
        
    }
    
    @objc private func handleTextChnage(forTextField textField : UITextField) {
        
        if textField  == streetAddress {
            validator.streetAddress = textField.text!
        }else if textField == city {
            validator.city = textField.text!
        }else if textField == state {
            validator.state = textField.text!
        }else if textField == zipCode {
            validator.zipCode = textField.text!
        }
        
    }
    
}

