//
//  Extension+String.swift
//  paylite
//
//  Created by James Amo on 12/01/2017.
//  Copyright © 2017 PayInc Group. All rights reserved.
//

import Foundation


extension String{
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    var isValidName :  Bool {
        let nameRegEx = "^[A-Za-z '-]+$"
        
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: self)
    }
}
