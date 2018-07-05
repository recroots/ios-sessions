//
//  ViewController.swift
//  MVVM
//
//  Created by Avismara HL on 03/07/18.
//  Copyright © 2018 Infrrd Technologies Private Limited. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var firstNameTextField : UITextField!
    @IBOutlet weak var lastNameTextField : UITextField!
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var registerLabel : UILabel!
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindRegisterLabel()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func bindRegisterLabel() {
        self.viewModel.state.bind { state in
            switch state {
            case .preregister :
                self.registerLabel.text = "Registering..."
            case .duringRegister :
                self.registerLabel.text = "Magic Posting the user details"
            case .postRegister :
                self.registerLabel.text = "Registered!"
            }
        }
    }
    
}

//MARK: Text Field Delegate Methods
extension ViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let validatorMapping = [self.firstNameTextField : self.viewModel.validateEmpty,self.lastNameTextField : self.viewModel.validateEmpty,self.emailTextField:self.viewModel.validateEmail,self.passwordTextField:self.viewModel.validatePassword]
        let validatorMethod = validatorMapping[textField]
        let validated = validatorMethod?(textField.text ?? "") ?? false
        if !validated {
            textField.shake()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ViewController {
    @IBAction func didTapDoneButton(sender : AnyObject?) {
        guard viewModel.validate() else {
            return
        }
        viewModel.postUserDetails()
    }
}

