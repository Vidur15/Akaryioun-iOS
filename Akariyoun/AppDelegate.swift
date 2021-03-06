//
//  AppDelegate.swift
//  Akariyoun
//
//  Created by vidur on 22/02/22.
//  Copyright © 2022 vidur. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import KYDrawerController
import AWSS3

// GITHUB PUSH TOKEN
// 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


var App = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let kSharedAppDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        IQKeyboardManager.shared.enableAutoToolbar = true
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewControlller = storyBoard.instantiateViewController(withIdentifier: "KYDrawerController") as? KYDrawerController ?? UIViewController()
        let navigationController = UINavigationController(rootViewController: viewControlller)
                navigationController.isNavigationBarHidden = true
                self.window?.rootViewController = navigationController
               self.window?.makeKeyAndVisible()
        self.initializeS3()
        
        if kSharedUserDefaults.getLanguageName() == nil {
        kSharedUserDefaults.setLanguage(languageName: "en")
        }
        self.setSemanticContentAttribute()
        
        UIApplication.shared.statusBarStyle = .lightContent
        // Override point for customization after application launch.
        return true
    }
    
    
    func initializeS3() {
        
        let accessKey = "AKIA6LSDBEL3U2HOJWLW"
        let secretKey = "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"
        
        let credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
        let configuration = AWSServiceConfiguration(region:AWSRegionType.USEast2, credentialsProvider:credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
    }

    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Akariyoun")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

extension AppDelegate {
    //MARK: localized func
    public func setSemanticContentAttribute() {
        
        if kSharedUserDefaults.getLanguageName() == "ar" {
            UIView.appearance().semanticContentAttribute            = UISemanticContentAttribute.forceRightToLeft
            UITableView.appearance().semanticContentAttribute       = UISemanticContentAttribute.forceRightToLeft
            UITextField.appearance().semanticContentAttribute       = UISemanticContentAttribute.forceRightToLeft
            UICollectionView.appearance().semanticContentAttribute       = UISemanticContentAttribute.forceRightToLeft
            UITextView.appearance().semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
            
        } else {
            
            UIView.appearance().semanticContentAttribute            = UISemanticContentAttribute.forceLeftToRight
            UITableView.appearance().semanticContentAttribute       = UISemanticContentAttribute.forceLeftToRight
            UITextField.appearance().semanticContentAttribute       = UISemanticContentAttribute.forceLeftToRight
            UICollectionView.appearance().semanticContentAttribute   = UISemanticContentAttribute.forceLeftToRight
            
            UITextView.appearance().semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
        }
    }
}
