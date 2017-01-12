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
        var termPos = -1
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
            case .TERM:
                termPos = courseDataItemStore.count
                courseDataItemStore.append(courseDataItem)
            default:
                courseDataItemStore.append(courseDataItem)
            }
            
        }
        
        if namePos != -1{
            (courseDataItemStore[0], courseDataItemStore[namePos]) = (courseDataItemStore[namePos], courseDataItemStore[0])
        }//move the name to the front
        
        if termPos != -1{
            (courseDataItemStore[1], courseDataItemStore[termPos]) = (courseDataItemStore[termPos], courseDataItemStore[1])
        }
        
        if time != "" && blockPos != -1 {
            courseDataItemStore[blockPos].appendRawInput(input: time)
            (courseDataItemStore[2], courseDataItemStore[blockPos]) = (courseDataItemStore[blockPos], courseDataItemStore[2])
        }//combine time and block
        
        if bookPos != -1 {
            (courseDataItemStore[courseDataItemStore.count-1], courseDataItemStore[bookPos]) = (courseDataItemStore[bookPos], courseDataItemStore[courseDataItemStore.count-1])
        }//move the book to the end
        
        for item in courseDataItemStore{
            item.execute()
        }//execute all, download concurrently
    }

    
    public func getResult(index: Int) -> [String]{
        return courseDataItemStore[index].resultList
    }
    
    public func isDone() -> Bool{
        var isDone = false
        for item in courseDataItemStore {
            isDone = isDone && item.isDone
        }
        return isDone
    }
    
    
}
