//
//  SignInViewController.swift
//  SignMeUp
//
//  Created by Lena Ngungu on 6/9/18.
//  Copyright © 2018 Lena Ngungu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User

class LogInViewController: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        // 2
        authUI.delegate = self
        let email = emailTextField.text!
        let password = passwordTextField.text!
        // 3
//        let authViewController = authUI.authViewController()
//        present(authViewController, animated: true)
        Auth.auth().signIn(withEmail: email, password: password)
        {(user,error) in
            guard let user = Auth.auth().currentUser
                
                else {
                    //Toast to let know user doesnt exist 
                    return }
            
            // 2
            let userRef = Database.database().reference().child("users").child(user.uid)
            
            userRef.observeSingleEvent(of: .value, with: { (snapshot) in
                if let user = User(snapshot: snapshot) {
                    User.setCurrent(user)
                    
                    //                let storyboard = UIStoryboard(name: "Main", bundle: .main)
                    //                if let initialViewController = storyboard.instantiateInitialViewController() {
                    //                    self.view.window?.rootViewController = initialViewController
                    //}
                    self.performSegue(withIdentifier: "logIn", sender: LogInViewController.self)
                    
                } else {
                    print("user does not exist")
                    // 1
                    // self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
                }
            })
          print("signed in successfully")
        }
    }
 

}

extension LogInViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        if let error = error {
            //if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
        }
        
        guard let user = user
            else { return }
        
        // 2
        let userRef = Database.database().reference().child("users").child(user.uid)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let user = User(snapshot: snapshot) {
                User.setCurrent(user)
                
//                let storyboard = UIStoryboard(name: "Main", bundle: .main)
//                if let initialViewController = storyboard.instantiateInitialViewController() {
//                    self.view.window?.rootViewController = initialViewController
                //}
                self.performSegue(withIdentifier: "logIn", sender: LogInViewController.self)
            
            } else {
                print("user does not exist")
                // 1
                // self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
            }
        })
        
    }
}
/*
 guard let firUser = Auth.auth().currentUser,
 let firstName = firstNameTextField.text, let lastName = lastNameTextField.text,
 !firstName.isEmpty else { return }
 
 UserService.create(firUser, firstName: firstName, lastName: lastName) { (user) in
 guard let user = user else {
 // handle error
 return
 }
 User.setCurrent(user, writeToUserDefaults: true)
 }
 
 
 }
 */
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

