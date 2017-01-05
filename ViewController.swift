//
//  ViewController.swift
//  BrandeisClassSearchIPHONE
//
//  Created by Yuanze Hu on 12/21/16.
//  Copyright © 2016 Yuanze Hu. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    var courseDictionary: CourseDictionary? = nil
    //the sourse of dictionary for search class

    @IBOutlet weak var centerText: UILabel!

    @IBOutlet weak var testingLongText: UITextView!
    
    override func viewDidLoad()
    {
        //
        super.viewDidLoad()
        view.endEditing(true)
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        courseDictionary = appDel.courseDictionary!
        if courseDictionary==nil{
            centerText.text = "no dictionary"
        }else if (courseDictionary?.txt.isEmpty)!{
            centerText.text = "empty dictionary"
        }else if (courseDictionary?.txt.isEmpty)!{
            print((courseDictionary?.txt.isEmpty)!)
            centerText.text = "dictionary ready"
        }else{
            centerText.text = "dictionary ready \(courseDictionary?.terms?[0])"
        }
        var s=""
        for term in (courseDictionary?.terms)!{
            s = s+term+"\n"
        }
        testingLongText.text=s
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func LeftSideMenuOpen(_ sender: Any) {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
        
        
    }//单击左上 打开菜单
    
    
    @IBAction func RightSideMenuOpen(_ sender: Any) {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.centerContainer!.toggle(MMDrawerSide.right, animated: true, completion: nil)
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
