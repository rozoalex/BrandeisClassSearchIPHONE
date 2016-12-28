//
//  AppDelegate.swift
//  BrandeisClassSearchIPHONE
//
//  Created by Yuanze Hu on 12/21/16.
//  Copyright © 2016 Yuanze Hu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let DataDirectory = NSHomeDirectory()+"/Data.txt"
    var window: UIWindow?
    var centerContainer: MMDrawerController?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        print("didFinishLaunchingWithOptions in AppDelegate")
        
        
        readFile()
        
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        let centerViewController = mainStoryboard.instantiateViewController(withIdentifier: "center")
        
        let leftViewController = mainStoryboard.instantiateViewController(withIdentifier: "LeftSideViewController") as! LeftSideViewController

        
        let leftSideNav = UINavigationController(rootViewController: leftViewController)
        
        leftSideNav.navigationBar.isHidden = true //hide the nav bar in LeftMenue
        
        let centerNav = UINavigationController(rootViewController: centerViewController)


        
        centerContainer = MMDrawerController(center: centerNav, leftDrawerViewController: leftSideNav)
        centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningCenterView;
        centerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView;
        window!.rootViewController = centerContainer
        window!.makeKeyAndVisible()
        return true
    }
    
    private func readFile(){
        let path = Bundle.main.path(forResource: "Data", ofType: "txt")
        do {
            var i = 0

            let start = DispatchTime.now() // <<<<<<<<<< Start time
            
            if let aStreamReader = StreamReader(path: path!) {
                defer {
                    aStreamReader.close()
                }
                
                while let line = aStreamReader.nextLine() {
                    i += 1
                    print(line)
                }
            }
            
            
            //let txt = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
            //let myStrings = txt.components(separatedBy: NSCharacterSet.newlines)
            
            let end = DispatchTime.now()   // <<<<<<<<<<   end time
            let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
            let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests
            print("lines:\(i)")
            print("Time : \(timeInterval) seconds")
            //print(txt)
        }catch{
            print("\(path)")
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

