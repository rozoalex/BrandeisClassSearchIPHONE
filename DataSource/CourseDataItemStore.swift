//
//  CourseDataItemStore.swift
//  BrandeisClassSearchIPHONE
//
//  Created by Yuanze Hu on 1/11/17.
//  Copyright © 2017 Yuanze Hu. All rights reserved.
//  stores an array of CourseDataItem a wrapper class

import Foundation

class CourseDataItemStore {
    var courseDataItemStore: [CourseDataItem]
    
    
    init(searchResultArray : [String]) {
        var blockPos = -1
        var bookPos = -1
        var namePos = -1
        var time = ""
        
        courseDataItemStore = []
        for result in searchResultArray{
            let courseDataItem = CourseDataItem(rawDataItem: result)
            switch courseDataItem.attribute {
            case .BLOCK:
                blockPos = courseDataItemStore.count
                courseDataItemStore.append(courseDataItem)
                break
            case .BOOK:
                bookPos = courseDataItemStore.count
                courseDataItemStore.append(courseDataItem)
                break
            case .TIME:
                time = courseDataItem.rawInput
                break
            case .NAME:
                namePos = courseDataItemStore.count
                courseDataItemStore.append(courseDataItem)
                break
            default:
                courseDataItemStore.append(courseDataItem)
            }
            
        }
        
        if namePos != -1{
            (courseDataItemStore[0], courseDataItemStore[namePos]) = (courseDataItemStore[namePos], courseDataItemStore[0])
        }//move the name to the front
        
        if time != "" && blockPos != -1 {
            courseDataItemStore[blockPos].appendRawInput(input: time)
            (courseDataItemStore[1], courseDataItemStore[blockPos]) = (courseDataItemStore[blockPos], courseDataItemStore[1])
        }//combine time and block
        
        if bookPos != -1 {
            (courseDataItemStore[courseDataItemStore.count-1], courseDataItemStore[bookPos]) = (courseDataItemStore[bookPos], courseDataItemStore[courseDataItemStore.count-1])
        }//move the book to the end
        
        for item in courseDataItemStore{
            item.execute()
        }//execute all, download concurrently
    }
    
    public func isDone() -> Bool{
        var isDone = false
        for item in courseDataItemStore {
            isDone = isDone && item.isDone
        }
        return isDone
    }
    
    
}
