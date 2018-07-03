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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: Text Field Delegate Methods
extension ViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let validatorMapping = [self.firstNameTextField : self.validateEmpty,self.lastNameTextField : self.validateEmpty,self.emailTextField:self.validateEmail,self.passwordTextField:self.validatePassword]
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
        
        guard validate() else {
            return
        }
        let services = Services()
        self.registerLabel.text = "Performing post magic to regsiter..."
        services.postRegistrationDetails(firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!, email: self.emailTextField.text!, password: self.passwordTextField.text!) { [weak self] in
            self?.registerLabel.text = "Registered!"
        }
    }
    
    private func validate() -> Bool {
        let validatorMapping = [self.firstNameTextField : self.validateEmpty,self.lastNameTextField : self.validateEmpty,self.emailTextField:self.validateEmail,self.passwordTextField:self.validatePassword]
        var validated = true
        for (key,value) in validatorMapping {
            if value(key.text ?? "") == false {
                validated = false
                key.shake()
            }
        }
        return validated
    }
}

//MARK: Validation Methods
extension ViewController {
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
        return emailTest.evaluate(with: text)
    }
}

