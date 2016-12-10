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
import FBSDKLoginKit
import FacebookCore
import FacebookLogin
import FacebookShare



class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    

    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions:  ["email"], from: self) { (result, error) in
            if error != nil {
                print("Akram: unable to authenticate with FB -\(error)")
            } else if result?.isCancelled == true {
                print("Akram: user cancelled FB authentication")
            } else {
                print("successul authentication")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: {(user, error) in
            if error != nil {
                print("Akram: unable to authen with firebase - \(error)")
            } else {
                print("Akram: Successfully authen with firebase")
            }
        })
    }


//    @IBAction func logIn(_ sender: Any) {
//        FIRAuth.auth()!.signIn(withEmail: emailField.text!,
//                               password: passwordField.text!) {
//                                (user, error) in
//                                if user != nil {
//                                    print(error)
//                                    print(user)
//                                    print("hi")
//                                    self.performSegue(withIdentifier: "logInSegue", sender: nil)
//                                }
//                                
//        }
//        
//        
//    }
//    
//    
//    @IBAction func signUp(_ sender: Any) {
//        let alert = UIAlertController(title: "Register",
//                                      message: "Register here",
//                                      preferredStyle: .alert)
//        
//        let saveAction = UIAlertAction(title: "Save",
//                                       style: .default) { action in
//        
//                                        
//                                        let SignUpEmailField = alert.textFields![0]
//                                        let SignUpPasswordField = alert.textFields![1]
//                                        print(4)
//                                        FIRAuth.auth()!.createUser(withEmail: SignUpEmailField.text!,
//                                                                   password: SignUpPasswordField.text!) { user, error in
//                                                                    if error == nil {
//                                                                        
//                                                                        FIRAuth.auth()!.signIn(withEmail: self.emailField.text!,
//                                                                                               password: self.passwordField.text!)
//                                                                    }
//                                        }
//
//        }
//        
//        
//        let cancelAction = UIAlertAction(title: "Cancel",
//                                         style: .default)
//        
//        alert.addTextField { textEmail in
//            textEmail.placeholder = "Enter your email"
//        }
//        
//        alert.addTextField { textPassword in
//            textPassword.isSecureTextEntry = true
//            textPassword.placeholder = "Enter your password"
//        }
//        print(1)
//
//        alert.addAction(saveAction)
//        alert.addAction(cancelAction)
//        print(2)
//
//        present(alert, animated: true, completion: nil)
//        print(3)
//
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
//            if user != nil {
//                self.performSegue(withIdentifier: "logInSegue", sender: nil)
//            }
//        }
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
