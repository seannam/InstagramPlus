//
//  LoginViewController.swift
//  InstagramPlus
//
//  Created by Sean Nam on 12/14/17.
//  Copyright © 2017 seannam. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var logoLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerUser(username: String, password: String) {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = username
        newUser.password = password
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User registered successfully")
            }
        }
    }
    
    func loginUser(username: String, password: String) {
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("user log in failed: \(error.localizedDescription)")
            } else {
                print("user logged in successfully")
            }
        }
    }
    
    @IBAction func onTapLoginButton(_ sender: Any) {
        print("login")
        let ready = checkEmptySignUpFields()
        if ready {
            loginUser(username: usernameTextField.text!, password: passwordTextField.text!)
        } else {
            print("login error")
        }
    }
    
    @IBAction func onTapSignUpButton(_ sender: Any) {
        print("signup")
        let ready = checkEmptySignUpFields()
        if ready {
            registerUser(username: usernameTextField.text!, password: passwordTextField.text!)
        } else {
            print("error on sign up")
        }
    }
    
    func checkEmptySignUpFields() -> Bool {
        if !(usernameTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)! {
            print("no empty fields")
            return true
        } else {
            print("empty fields")
            return false
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
