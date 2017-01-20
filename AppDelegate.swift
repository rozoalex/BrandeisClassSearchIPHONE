//
//  AppDelegate.swift
//  BrandeisClassSearchIPHONE
//
//  Created by Yuanze Hu on 12/21/16.
//  Copyright © 2016 Yuanze Hu. All rights reserved.
//

import UIKit
import MMDrawerController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var centerContainer: MMDrawerController?
    
    var theViewController: ViewController?
    
    var courseDictionary: CourseDictionary?
    
    var descCell : TableCellDescription?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        print("didFinishLaunchingWithOptions in AppDelegate")
        
        
        courseDictionary = CourseDictionary(fileName: "Data")
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        let centerViewController = mainStoryboard.instantiateViewController(withIdentifier: "center")
        
        let centerVC = centerViewController as! ViewController
        
        theViewController = centerVC
        
        centerVC.navigationController?.navigationBar.tintColor = UIColor(red: 63.0/255.0, green: 81.0/255.0, blue: 181.0/255.0, alpha: 1.0)
        
        centerVC.courseDictionary = courseDictionary//set the dictionary to ui
        
        
        let leftViewController = mainStoryboard.instantiateViewController(withIdentifier: "LeftSideViewController") as! LeftSideViewController
        
        let rightViewController = mainStoryboard.instantiateViewController(withIdentifier: "RightSideViewController") as! RightSideViewController

        
        let leftSideNav = UINavigationController(rootViewController: leftViewController)
        
        let rightSideNav = UINavigationController(rootViewController: rightViewController)
        
        leftSideNav.navigationBar.isHidden = true //hide the nav bar in LeftMenue
        
        rightSideNav.navigationBar.isHidden = true
        
        let centerNav = UINavigationController(rootViewController: centerViewController)

        
        
        
        centerContainer = MMDrawerController(center: centerNav, leftDrawerViewController: leftSideNav, rightDrawerViewController: rightSideNav)
        
        //UINavigationBar.appearance().barTintColor =
        
        centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningCenterView;
        centerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView;
        window!.rootViewController = centerContainer
        window!.makeKeyAndVisible()
        return true
    }
    
 
    public func setDescCell(descCell: TableCellDescription){
        self.descCell = descCell
    }
    
    
   
    
    func addHistory(newHistory: String){
        if(courseDictionary != nil){
            courseDictionary?.addHistory(newHist: newHistory)
        }else{
            print("dictionary is nil")
        }
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        print("applicationWillResignActive")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("applicationdIDidEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("applicationWillEnterForeground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("applicationDidBecomeActive")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("applicationWillTerminate")
    }


}

