//
//  CourseDataItem.swift
//  BrandeisClassSearchIPHONE
//
//  Created by Yuanze Hu on 1/9/17.
//  Copyright © 2017 Yuanze Hu. All rights reserved.
//

import Foundation
import Alamofire
import Kanna

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
    var rawInput: String
    var resultList = [String]()
    
    //no internet connection during init step, nothing is done
    //resultlList is not empty only if execute() is called
    init(rawDataItem: String) {
        for s in attributeList{
            if rawDataItem.hasPrefix(s.getHeader()){
                attribute = s
                rawInput = rawDataItem.replacingOccurrences(of: s.getHeader(), with: "").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                return
            }
        }
        print("Error in CourseDataItem, rawDataItem: \(rawDataItem)")
        rawInput = Error
        attribute=Attribute.ERROR
    }
    
    //the method called from outside to start downloading stuffs
    func execute(){
        fetchResult()
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
            print("Error ,can't fetch")
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
        resultList.append(rawInput)
    }
    
    private func doFetchDescription(){
        
        
    }
    
    private func doFetchTerm(){
        
    }
    

//    public func doFetch(urlString: String) -> URLSessionDataTask{
//        var rawHtml = ""
//        let components = NSURLComponents( string: urlString)!
//        
//        let baidu = components.url
//        let request = URLRequest( url: baidu!)
//        print("vvv")
//        let session: URLSession = {
//            let config = URLSessionConfiguration.default
//            return URLSession( configuration: config) }()
//        print("cc")
//        let task = session.dataTask(with: request) { (data, response, error) -> Void in
//            
//            if let htmlData = data {
//                if let jsonString = NSString( data: htmlData, encoding: String.Encoding.utf8.rawValue) {
//                    rawHtml = jsonString as String
//                    print("fetch successful \n*******\n\(rawHtml)\n*******")
//                    //self.resultList = self.setResult()
//                }
//            } else if let requestError = error {
//                rawHtml = self.Error
//                print(" Error fetching recent photos: \( requestError)")
//            } else {
//                rawHtml = self.Error
//                print(" Unexpected error with the request")
//            }
//            
//        }
//        
//        return task
//    }
    
    private func doFetchWithAlamofire(urlString: String) {
        Alamofire.request(urlString).responseString(completionHandler: {
            response in
            print("is Successful?? \(response.result.isSuccess)")
            if let html = response.result.value {
                self.resultList = self.setResult(htmlString: html)
            }else{
                print("url not working, url: \(urlString)")
            }
            
        
        
        })
        
        
    }
    
    
    //for now only these three needs to be parsed
    private func setResult(htmlString:String) -> [String]{
        switch attribute {
        case .TEACHER:
            return parseWithKannaTeacher(htmlString: htmlString)
        case .DESCRIPTION:
            return parseWithKannaDescription(htmlString: htmlString)
        case .BOOK:
            return parseWithKannaBook(htmlString: htmlString)
        default:
            print("setResult is nothing Attri:  \(attribute.getHeader())")
            return []
        }
    }
    
    
    private func parseWithKannaTeacher(htmlString: String) -> [String] {
        return []
    }
    
    //the simplest one
    private func parseWithKannaDescription(htmlString: String) -> [String] {
        if let doc = Kanna.HTML(html: htmlString, encoding: String.Encoding.utf8) {
            var desc = [""]
            var tempString = ""
            let requirements = doc.css("body span")
            for s in requirements{
                tempString.append(s.text!+"  ")
            }
            if requirements.count>0{
                tempString.append("\n")
            }
            let body = doc.css("body p")
            if body.count<1{
                return []
            }
            tempString.append(body[0].text!)
            desc[0]=tempString
            return desc
        }else{
            print("parseWithKannaDescription Failed  htmlString: \(htmlString)")
            return []
        }
    }
    
    private func parseWithKannaBook(htmlString: String) -> [String] {
        
        return []
    }
    
    
    
    
    
    
    
    
}
