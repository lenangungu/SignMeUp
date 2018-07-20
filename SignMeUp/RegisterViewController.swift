//
//  SignUpViewController.swift
//  SignMeUp
//
//  Created by Lena Ngungu on 6/9/18.
//  Copyright © 2018 Lena Ngungu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase

//typealias FIRUser = FirebaseAuth.User

class RegisterViewController: UIViewController {

    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func unwindToRegisterViewController(_ segue: UIStoryboardSegue)
    {
        
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
       
//        guard let authUI = FUIAuth.defaultAuthUI()
//            else { return }
//        authUI.delegate = self as? FUIAuthDelegate
        if let email = emailTextField.text {
            if let password = passwordTextField.text{
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let firUser = Auth.auth().currentUser,
                !email.isEmpty else { return }
            
            let firstName = self.firstNameTextField.text!
            let lastName = self.lastNameTextField.text!
            UserService.create(firUser, firstName: firstName, lastName: lastName) { (user) in
                guard let user = user else {
                    // handle error
                    return
                }
                
                User.setCurrent(user, writeToUserDefaults: true)
                
                self.performSegue(withIdentifier: "logIn", sender: self)
            }
            
            guard let email = authResult?.email, error == nil else {
                return
            }
                }
            }
        }
    
            
        
    }
    
    
}



