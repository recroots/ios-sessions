//
//  Services.swift
//  MVVM
//
//  Created by Avismara HL on 03/07/18.
//  Copyright © 2018 Infrrd Technologies Private Limited. All rights reserved.
//

import Foundation

struct Services {
    func postRegistrationDetails(firstName : String, lastName : String, email : String, password : String, success : @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
            success()
        }
    }
}
