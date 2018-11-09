//
//  ViewController.swift
//  TestFBSDKLOGIN
//
//  Created by vamshi on 09/11/18.
//  Copyright © 2018 vamshi. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FacebookCore   //For LoginManager class
import FacebookLogin


class ViewController: UIViewController,FBSDKLoginButtonDelegate {
   
    let loginMangrObj =   FBSDKLoginManager()
    var loginManagerObj = LoginManager()


    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        
       
        
    }
    
    func getUserProfilePic(){
        
        
        let propic = FBSDKProfilePictureView(frame: CGRect(x: 100, y: 200, width: 200, height: 200 ))
        propic.profileID = FBSDKAccessToken.current().userID
        self.view.addSubview(propic)
    }
    
    
    func firstWay(){
        
        print(FBSDKAccessToken.currentAccessTokenIsActive())
        
        if FBSDKAccessToken.currentAccessTokenIsActive(){
            print("Logged in")
            
        }else{
            print("Logged out")
        }
        
        
        if FBSDKAccessToken.current() != nil{
            print("Logged in")
        }else{
            print("Logged out")
        }
        
        let loginBtn = FBSDKLoginButton()
        loginBtn.delegate = self
        loginBtn.center = self.view.center
        loginBtn.readPermissions = ["public_profile","email"]
        
        self.view.addSubview(loginBtn)
        
    }
    
    @IBAction func onCustomLoginBtnTapped(_ sender: Any) {
        
     loginManagerObj.logIn(readPermissions: [.publicProfile,.email], viewController: self)
        {
            (loginResult) in
            
            switch loginResult
            {
                
            case .failed(let error):
                print(error.localizedDescription)
                break
                
                
            case .cancelled:
                print("user cancelled")
                break
                
                
            case .success(grantedPermissions: let grantedPermissions, declinedPermissions: let declinedPermissions, token: let accessTokens):
                
                print("grantedPermissions is \(grantedPermissions)")
                print("declinedPermissions is \(declinedPermissions)")
                print("accessTokens is \(accessTokens)")
                
                let para = ["fields":"name,id,email,first_name,last_name,picture.type(large)"]
                
                GraphRequest.init(graphPath: "me", parameters: para, accessToken: accessTokens).start(
                    {
                        (resp, result) in
                        
                        
                        
                        print("result is \(result)")
                        
                        switch result
                        {
                            
                        case .failed(let error):
                            print(error.localizedDescription)
                            break
                            
                        case .success(response: let grphResp):
                            
                            if let respDict = grphResp.dictionaryValue
                            {
                                print("respDict >>>> \(respDict)")
                                print("Name =====\(respDict["name"]!)")
                                print("FirstName =====\(respDict["first_name"]!)")
                                print("LastName =====\(respDict["last_name"]!)")
                                print("Picture =====\(respDict["picture"]!)")
                                
                                
                
                                
                            }
                            
                            
                            
                            
                            
                        }
                        
                })
                
                break
                
                
                
                
                
            }
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil{
            print(error.localizedDescription)
        }else if result.isCancelled{
            print("User Cancelled")
        }else{
            
            print("Logged in successfully")
        }
        
        
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("OMG LogOut")
    }

}

