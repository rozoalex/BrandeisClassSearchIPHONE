//
//  CourseDataItem.swift
//  BrandeisClassSearchIPHONE
//
//  Created by Yuanze Hu on 1/9/17.
//  Copyright © 2017 Yuanze Hu. All rights reserved.
//

import Foundation

public enum Attribute {
    case NAME, BOOK, BLOCK, TIME, TEACHER, SYLLABUS, DESCRIPTION, TERM, ERROR
    
    func getHeader() -> String{
        switch  self {
        case .NAME:
            return "NAME:"
        case .BOOK:
            return "BOOKS:"
        case .BLOCK:
            return "BLOCK:"
        case .TIME:
            return "TIMES:"
        case .TEACHER:
            return "TEACHER:"
        case .SYLLABUS:
            return "SYLLABUS:"
        case .DESCRIPTION:
            return "DESCRIPTION:"
        case .TERM:
            return "TERM:"
        case .ERROR:
            print("Error")
            return ""
        }
    }
}

public let attributeList = [Attribute.NAME,Attribute.BOOK,Attribute.BLOCK,Attribute.TIME,Attribute.TEACHER,Attribute.SYLLABUS,Attribute.DESCRIPTION,Attribute.TERM]


class CourseDataItem {
    let Error = "Error"
    var attribute: Attribute
    
    var resultList = [String]()
    
    
    init(rawDataItem: String) {
        for s in attributeList{
            if rawDataItem.hasPrefix(s.getHeader()){
                attribute = s
                //改成task
                fetchResult()
                //改成task
                return
            }
        }
        print("Error in CourseDataItem, rawDataItem: \(rawDataItem)")
        attribute=Attribute.ERROR
    }
    
    
    
    private func fetchResult(){
        switch  attribute {
        case .NAME:
            doFetchName()
            break
        case .BOOK:
            doFetchBook()
            break
        case .BLOCK:
            doFetchBlock()
            break
        case .TIME:
            doFetchTime()
            break
        case .TEACHER:
            doFetchTeacher()
            break
        case .SYLLABUS:
            doFetchSyllabus()
            break
        case .DESCRIPTION:
            doFetchDescription()
        case .TERM:
            doFetchTerm()
            break
        case .ERROR:
            print("Error can't fetch")
            break
        }
    }
    
    private func doFetchName(){
        
    }
    
    private func doFetchBook(){
        
    }
    
    private func doFetchBlock(){
        
    }
    
    private func doFetchTime(){
        
    }
    
    private func doFetchTeacher(){
        
    }
    
    private func doFetchSyllabus(){
        
    }
    
    private func doFetchDescription(){
        
    }
    
    private func doFetchTerm(){
        
    }
    

    public func doFetch(urlString: String) -> String{
        var rawHtml = ""
        let components = NSURLComponents( string: urlString)!
        
        let baidu = components.url
        let request = URLRequest( url: baidu!)
        print("vvv")
        let session: URLSession = {
            let config = URLSessionConfiguration.default
            return URLSession( configuration: config) }()
        print("cc")
        let task = session.dataTask(with: request) { (data, response, error) -> Void in
            
            if let jsonData = data {
                if let jsonString = NSString( data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                    rawHtml = jsonString as String
                }
            } else if let requestError = error {
                rawHtml = self.Error
                print(" Error fetching recent photos: \( requestError)")
            } else {
                rawHtml = self.Error
                print(" Unexpected error with the request")
            }
            
        }
        task.resume()
        return rawHtml
    }
    
    
    
    
    
    
    
    
}
