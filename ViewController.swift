//
//  ViewController.swift
//  BrandeisClassSearchIPHONE
//
//  Created by Yuanze Hu on 12/21/16.
//  Copyright © 2016 Yuanze Hu. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    var courseDataItemStore: CourseDataItemStore?
    var courseDictionary: CourseDictionary?
    //the sourse of dictionary for search class

    @IBOutlet weak var centerText: UILabel!

    @IBOutlet weak var testingLongText: UITextView!
    
    override func viewDidLoad()
    {
        //
        super.viewDidLoad()
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        courseDictionary = appDel.courseDictionary!

        
        if (courseDictionary?.history!.count)! > 0 {
          //  var ss = ""
            //for s in (courseDictionary?.history)!{
              //  ss = ss + s + "\n"
            //}
            //testingLongText.text = ss
            //centerText.text = courseDictionary?.latestHistory()
            let ar = courseDictionary?.search(courseID: (courseDictionary?.latestHistory())!)
            courseDataItemStore = CourseDataItemStore(searchResultArray: ar!)
            
            var ss = ""
            for s in ar! {
                ss  = ss + s + "\n"
            }
            print(ss)
            testingLongText.text=ss
            
            
        }else{
            var s=""
            for term in (courseDictionary?.terms)!{
                s = s+term+"\n"
            }
            testingLongText.text=s
        }
        UINavigationBar.appearance().barTintColor = UIColor(red: 63.0/255.0, green: 81.0/255.0, blue: 181.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor=UIColor(red: 63.0/255.0, green: 81.0/255.0, blue: 181.0/255.0, alpha: 1.0)

        // Do any additional setup after loading the view, typically from a nib.
        
    }

       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if courseDataItemStore == nil {
            return 0
        }else{
            return courseDataItemStore!.courseDataItemStore.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let a : Attribute = (courseDataItemStore?.courseDataItemStore[indexPath.row].attribute)!
        switch a {
        case .NAME :
            return setNameCell(table: tableView, index: indexPath)
        case .BLOCK :
            return setBlockCell(table: tableView, index: indexPath)
        case .TERM :
            return setTermCell(table: tableView, index: indexPath)
        default:
            print("dafuq? index:\(indexPath.row)")
            return UITableViewCell ()
        }
    }
    
    //set each table cell
    //Cells dont need internet connection
    private func setNameCell(table: UITableView, index: IndexPath) -> UITableViewCell{
        let mycell = table.dequeueReusableCell(withIdentifier: "TableCellName", for: index) as! TableCellName
        mycell.courseIDlabel.text = courseDictionary?.latestHistory()
        print("setNameCell: \(mycell.courseIDlabel.text)")
        mycell.courseNameLabel.text = courseDataItemStore?.getResult(index: index.row)[0]
        print("setNameCell: \(mycell.courseNameLabel.text)")
        return mycell;
        
    }
    
    private func setTermCell(table: UITableView, index: IndexPath) -> UITableViewCell{
        let mycell = table.dequeueReusableCell(withIdentifier: "TableCellYear", for: index) as! TableCellYear
        mycell.yearLabel.text = courseDataItemStore?.getResult(index: index.row)[0]
        return mycell
    }
    
    private func setBlockCell(table: UITableView, index: IndexPath) -> UITableViewCell{
        let mycell = table.dequeueReusableCell(withIdentifier: "TableCellTime", for: index) as! TableCellTime
        let result = courseDataItemStore?.getResult(index: index.row)[0].components(separatedBy: "\n")
        if result == nil{
            return UITableViewCell()
        }else if (result?.count)! < 1 {
            return UITableViewCell()
        }
        mycell.blockLabel.text = result?[0]
        print("setBlockCell : \(mycell.blockLabel.text)")
        var temp = ""
        for s in result! {
            temp = temp + "\n" + s
        }
        mycell.timeLabel.text = temp
        print("setBlockCell : \(temp)")
        return mycell
    }
    //Cells dont need internet connection
    
    private func setDescCell(table: UITableView, index: IndexPath) -> UITableViewCell{
        let mycell = table.dequeueReusableCell(withIdentifier: "TableCellDescription", for: index) as! TableCellDescription
        mycell.setSpinnerForWaitingData()
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setDescCell(descCell: mycell)
        return mycell
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

//extension UIViewController {
//    func hideKeyboardWhenTappedAround() {
//        let tap: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
//    }
//    
//    func hideKeyboardWhenScroll() {
//        let swipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        swipe.direction = UISwipeGestureRecognizerDirection.up
//        view.addGestureRecognizer(swipe)
//        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        swipe.direction = UISwipeGestureRecognizerDirection.down
//        view.addGestureRecognizer(swipeDown)
//    }
//    
//    func dismissKeyboard() {
//        view.endEditing(true)
//    }
//}
