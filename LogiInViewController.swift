//
//  LogiInViewController.swift
//  finalProjectMA
//
//  Created by Akram Rasikh on 09/12/2016.
//  Copyright © 2016 MAfinalProjectGroup. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit


class LogInViewController: UIViewController {
    var activeUser: FIRUser!
    
    @IBAction func facebookBtnTapped(_ sender: AnyObject) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            print("1")
            if error != nil {
                print("Akram: unable to authen with facebook - \(error)")
            } else if result?.isCancelled == true {
                print("Akram User cancelled FB auth")
            } else {
                print("2")
                print(user.self)
                print("Akram: successful authen with FB")
                print("3")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("Akram: unable to authenticate with - \(error)")
            } else {
                print("4")
                print(user!)
                print("Akram: successful authen with FB")
                
            }
        })
    }    
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!


    @IBAction func logIn(_ sender: Any) {
        FIRAuth.auth()!.signIn(withEmail: emailField.text!,
                               password: passwordField.text!) {
                                (user, error) in
                                if let user = user {
                                    if self.activeUser != user {
                                        self.activeUser = user
                                        self.performSegue(withIdentifier: "logInSegue", sender: nil)
                                    }
                                    
                                } else {
                                    self.errorLabel.text = (error?.localizedDescription)! as String
                                }
                                
        }
        
        
    }

    
    
    @IBAction func signUp(_ sender: Any) {
        let alert = UIAlertController(title: "Register",
                                      message: "Register here",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
        
                                        
                                        let SignUpEmailField = alert.textFields![0]
                                        let SignUpPasswordField = alert.textFields![1]
                                        print(4)
                                        FIRAuth.auth()!.createUser(withEmail: SignUpEmailField.text!,
                                                                   password: SignUpPasswordField.text!) { user, error in
                                                                    if error == nil {
                                                                        
                                                                        FIRAuth.auth()!.signIn(withEmail: self.emailField.text!,
                                                                                               password: self.passwordField.text!)
                                                                    }
                                                                    else {
                                                                        self.errorLabel.text = (error?.localizedDescription)! as String
                                                                    }
                                        }

        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        print(1)

        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        print(2)

        present(alert, animated: true, completion: nil)
        print(3)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let loginButton = FBSDKLoginButton()
//        
//        view.addSubview(loginButton)
//        
//        loginButton.delegate = self
        
        self.errorLabel.text = ""
        print("hello")
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if let user = user {
                if self.activeUser != user {
                    self.activeUser = user
                    self.performSegue(withIdentifier: "logInSegue", sender: nil)

                }
            }
        }
        // Do any additional setup after loading the view.
    }
//    
//    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
//        print("Did log out")
//    }
//    
//    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
//        if error != nil {
//            print(error)
//            return
//        }
//        
//        print("successful login")
//     
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
