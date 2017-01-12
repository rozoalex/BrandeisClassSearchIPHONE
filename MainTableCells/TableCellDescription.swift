//
//  TableCellDescription.swift
//  BrandeisClassSearchIPHONE
//
//  Created by Yuanze Hu on 1/12/17.
//  Copyright © 2017 Yuanze Hu. All rights reserved.
//

import UIKit

class TableCellDescription: UITableViewCell {

    @IBOutlet weak var descText: UITextView!
    var courseDataItem: CourseDataItem?
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    public func setSpinnerForWaitingData(){
        descText.isHidden = true
        spinner.isHidden = false
        print("TableCellDescription waits for data")
    }
    
    public func refreshData(){
        descText.isHidden = false
        descText.text = courseDataItem?.resultList[0]
        spinner.isHidden = true
        print("refresh description cell:\n\(descText.text)")
    }
    
    
    

}
