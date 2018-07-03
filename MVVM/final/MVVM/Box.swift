//
//  Box.swift
//  MVVM
//
//  Created by Avismara HL on 03/07/18.
//  Copyright © 2018 Infrrd Technologies Private Limited. All rights reserved.
//

import Foundation
class Box<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(self.value)
    }
    
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(value v: T) {
        value = v
    }
    
}


