//  ViewController.swift
//  Instagram Clone iOS
//  Created by Jerry Tan on 24/09/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit

class ViewController: UIViewController {
    
    ////check sign up mode is active variable
    var signupModeisActive = true
    
    
    
    
    
    
    //MARK: - email and password IB outlets
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    //MARK: - sign up or login action and outlet
    @IBOutlet weak var signupOrLoginOutlet: UIButton!
    @IBAction func signupOrLogin(_ sender: Any) {
    
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

