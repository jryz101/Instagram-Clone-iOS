//  ViewController.swift
//  Instagram Clone iOS
//  Created by Jerry Tan on 24/09/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit
import Parse

class ViewController: UIViewController {
    
    ////check sign up mode is active variable
    var signupModeisActive = true
    
    
    
    
    //MARK: - display alert function
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)

    }
    
    
    
    
    
    
    //MARK: - email and password IB outlets
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    
    
    
    
    
    
    //MARK: - sign up or login action and outlet
    @IBOutlet weak var signupOrLoginOutlet: UIButton!
    @IBAction func signupOrLogin(_ sender: Any) {
        
        ////methods for checking error input and display alert message
        if email.text == "" || password.text == "" {
            
            displayAlert(title: "Error In Form", message: "Please enter an email and pasword")
            
            
        } else {
            
            ////spinner activity indicator
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = UIActivityIndicatorView.Style.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            
            ////methods for signing up user with email and password
            if (signupModeisActive) {
                
                let user = PFUser()
                
                user.username = email.text
                user.password = password.text
                user.email = email.text
                
                ////Signs up the user *asynchronously*
                user.signUpInBackground { (success, error) in
                    
                    
                    ////Stops the animation of the progress indicator
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    
                    if let error = error {
                        
                        self.displayAlert(title:"Could Not Sign Up", message: error.localizedDescription)
                        
                    } else {
                        
                        print("Signing Up")
                        
                    }
                    
                }
                
            } else {
                
                ////methods for log in user with email and password
                PFUser.logInWithUsername(inBackground: email.text!, password: password.text!) { (user, error) in
                    
                    ////Stops the animation of the progress indicator
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if user != nil {
                        
                        print("Login Sucessfull")
                        
                    } else {
                        
                        var errorText = "UNKNOWN ERROR: Please Try Again"
                        
                        if let error = error {
                            
                            errorText = error.localizedDescription
                            
                        }
                        
                        self.displayAlert(title:"Could Not Sign Up", message: errorText)
                        
                        }
                
                    }
                
                }
            
            }
    
        }
    
    
    
    
    
    
    
    
    //MARK: - switch to login action and outlet
    @IBOutlet weak var switchToLoginModeOutlet: UIButton!
    @IBAction func switchToLoginMode(_ sender: Any) {
        
        ////methods for switching between sign up and log in mode
        if (signupModeisActive) {
            
            signupModeisActive = false
            
            signupOrLoginOutlet.setTitle("Log In", for: [])
            switchToLoginModeOutlet.setTitle("Sign Up", for: [])
            
        } else {
            
            signupModeisActive = true
            
            signupOrLoginOutlet.setTitle("Sign Up", for: [])
            switchToLoginModeOutlet.setTitle("Log In", for: [])
        }
    
    }
    
    
    
    //MARK: - view did load section
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

