//
//  LoginViewController.swift
//  KDNProject
//
//  Created by 조주혁 on 2020/10/07.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInDelegate{
    
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        GIDSignIn.sharedInstance().delegate = self
    
        GIDSignIn.sharedInstance()?.presentingViewController = self

        GIDSignIn.sharedInstance().signIn()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func goMainPage(){
        guard let goMain = self.storyboard?.instantiateViewController(identifier: "MainPage") else { return }
        goMain.modalPresentationStyle = .fullScreen
        self.present(goMain, animated: true)
    }
    
    @available(iOS 10.0, *)
    func application(
            _ app: UIApplication,
            open url: URL,
            options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
            print("b")
            return GIDSignIn.sharedInstance().handle(url)
        }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...

        guard error == nil else{
            
            if let error = error{
                print("fail to sing in with google: \(error)")
            }
            return
            
        }
        
        
        print("a")
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Firebase.Auth.auth().signIn(with: credential, completion: {AuthResult, error in
            guard AuthResult != nil , error == nil else {
                print("Fail to log in with google ")
                return
            }
            print("successfully signed in with google")
            self.goMainPage()
        })
        
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("google user was disconnected")
    }
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
