//
//  ViewModel.swift
//  MVVM
//
//  Created by Avismara HL on 03/07/18.
//  Copyright © 2018 Infrrd Technologies Private Limited. All rights reserved.
//

import Foundation

class ViewModel {
    
    
    enum RegistrationState {
        case preregister
        case duringRegister
        case postRegister
    }
    
    var firstName : String = ""
    var lastName : String = ""
    var emailID : String = ""
    var password : String = ""

    var state : Box<RegistrationState> = Box<RegistrationState>(value: .preregister)
    
    func validate() -> Bool {
        //We'll come to this later
        return true
    }
    
    func validateEmpty(text : String) -> Bool {
        return !text.isEmpty
    }
    
    func validatePassword(text : String) -> Bool {
        let passwordLength = text.count
        if passwordLength < 6 {
            return false
        }
        return true
    }
    
    func validateEmail(text : String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let validated = emailTest.evaluate(with: text)
        if validated {
            return true
        } else {
            return false
        }
    }
    
    func postUserDetails() {
        let services = Services()
        self.state.value = .duringRegister
        services.postRegistrationDetails(firstName: self.firstName, lastName: self.lastName, email: self.emailID, password: self.password) { [weak self] in
            self?.state.value = .postRegister
        }
    }
    
}
