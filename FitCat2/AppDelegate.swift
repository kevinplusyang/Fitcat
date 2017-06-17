//
//  AppDelegate.swift
//  FitCat2
//  Created by Ming Yang on 11/21/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit
import GoogleSignIn
import IQKeyboardManagerSwift
import Firebase
import FirebaseAuth
import FBSDKCoreKit
import FirebaseDatabase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    

    var window: UIWindow?
    var userDefaults = UserDefaults.standard
    var navigationController = UINavigationController()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.sharedManager().enable = true
        self.window = UIWindow(frame: UIScreen.main.bounds)
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        let backImage = UIImage(named: "backBtn")
        navigationController.navigationBar.backIndicatorImage = backImage
        navigationController.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController.navigationBar.tintColor = .white
        self.window!.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
  
        FIRApp.configure()
        //Enables local copy of db just in case user is offline
        FIRDatabase.database().persistenceEnabled = true
        do {
            //try FIRAuth.auth()?.signOut()
        } catch {
            
        }
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        if let activeUser = FIRAuth.auth()?.currentUser {
            let userRef = FIRDatabase.database().reference(withPath: "users").child(activeUser.uid)
            userRef.keepSynced(true)
        }
        
        startSignIn()
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        
        return url.absoluteString.contains("google") ? GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
        annotation: annotation) : handled
    }
    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print("Error in didSignInFor", error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        FIRAuth.auth()?.signIn(with: credential) { (fireUser, error) in
            if let error = error {
                print("Error in signInAuth", error)
                return
            }
            //Signed in
            if let fireUser = fireUser {
            userDidSignIn(fireUser)
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        print("App will resign active")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("App in background")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("App Terminated")
    }


}

