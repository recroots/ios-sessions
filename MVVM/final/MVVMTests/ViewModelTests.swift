//
//  MVVMTests.swift
//  MVVMTests
//
//  Created by Avismara HL on 03/07/18.
//  Copyright © 2018 Infrrd Technologies Private Limited. All rights reserved.
//

import XCTest

@testable import MVVM

class ViewModelTests: XCTestCase {
    
    
    let viewModel = ViewModel()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCorrectnessOfValidateEmailMethod() {
        
        //Setup the variables/initialise
        let email = "avismara@infrrd.ai"
        
        //Perform the action
        let validated = viewModel.validateEmail(text: email)
        
        //Assert or test if the code has done what it is meant to do
        XCTAssert(validated)
    }
    
    func testBadEmail() {
        let email = "aksdjfas"
        let validated = viewModel.validateEmail(text: email)
        XCTAssert(!validated)
    }
    
    //Do a bit of reading on testing asynchronous calls
    
    //Promise/fulfill pattern
    
    //Measuring performance
}
