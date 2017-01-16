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

enum Attribute {
    case NAME, BOOK, BLOCK, TIME, TEACHER, SYLLABUS, DESCRIPTION, TERM, ERROR
    
    func getHeader() -> String{
        switch self {
            
        case Attribute.NAME:
            return "NAME:"
        case Attribute.BOOK:
            return "BOOKS:"
        case Attribute.BLOCK:
            return "BLOCK:"
        case Attribute.TIME:
            return "TIMES:"
        case Attribute.TEACHER:
            return "TEACHER:"
        case Attribute.SYLLABUS:
            return "SYLLABUS:"
        case Attribute.DESCRIPTION:
            return "DESCRIPTION:"
        case Attribute.TERM:
            return "TERM:"
        case Attribute.ERROR:
            print("Error")
            return ""
        }
    }
}

let attributeList = [Attribute.NAME,Attribute.BOOK,Attribute.BLOCK,Attribute.TIME,Attribute.TEACHER,Attribute.SYLLABUS,Attribute.DESCRIPTION,Attribute.TERM]


class CourseDataItem {
    let Error = "Error"
    var attribute: Attribute = Attribute.ERROR
    var rawInput: String = ""
    var resultList = [String]()
    var isDone = false
    
    //no internet connection during init step, nothing is done
    //resultlList is not empty only if execute() is called
    init(rawDataItem: String) {
        print("sssgqrhe")
        let rawData = rawDataItem.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        for s in attributeList{
            if rawData.hasPrefix(getHeader(atrr: s)){
                attribute = s
                rawInput = rawData.replacingOccurrences(of: getHeader(atrr: s), with: "").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                return
            }
        }
        print("Error in CourseDataItem, rawDataItem: \(rawDataItem)")
        rawInput = Error
        attribute=Attribute.ERROR
    }
    
    func getHeader(atrr : Attribute) -> String{
        switch atrr {
            
        case Attribute.NAME:
            return "NAME:"
        case Attribute.BOOK:
            return "BOOKS:"
        case Attribute.BLOCK:
            return "BLOCK:"
        case Attribute.TIME:
            return "TIMES:"
        case Attribute.TEACHER:
            return "TEACHER:"
        case Attribute.SYLLABUS:
            return "SYLLABUS:"
        case Attribute.DESCRIPTION:
            return "DESCRIPTION:"
        case Attribute.TERM:
            return "TERM:"
        case Attribute.ERROR:
            print("Error")
            return ""
        }
    }
    
    public func appendRawInput(input: String)  {
        self.rawInput = rawInput + "\n\(input)"
        print("appended raw Inp: \(self.rawInput)")
    }
    
    
    //the method called from outside to start downloading stuffs
    public func execute(){
        if attribute == .BOOK || attribute == .DESCRIPTION || attribute == .TEACHER || attribute == .SYLLABUS{
            let queue = DispatchQueue(label: attribute.getHeader())
            queue.async {
                print("new Background thread for \(self.attribute.getHeader())\n")
                self.doFetchWithAlamofire(urlString: self.rawInput)
            }
        }else if attribute == .ERROR {
            print("Error ,can't fetch")
        }else{
            doFetchRaw()
        }
    }
    
    private func doFetchRaw(){
        resultList.append(rawInput)
        isDone = true
    }

    private func doFetchWithAlamofire(urlString: String) {

        Alamofire.request(urlString).responseString(completionHandler: {
            response in
            print("is Successful?? \(response.result.isSuccess)")
            if let html = response.result.value {
                let result = self.setResult(htmlString: html)
                if result.count >= 1 {
                    self.resultList = result
                    print("doFetchWithAlamofire ok set result list to \(self.resultList[0])")
                }
                self.isDone = true
            }else{
                print("url not working, url: \(urlString)")
                self.isDone = true
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
        case .SYLLABUS:
            return parseWithKannaSyllabus(htmlString: htmlString)
        default:
            print("setResult is nothing Attri:  \(attribute.getHeader())")
            return []
        }
    }
    
    
    private func parseWithKannaTeacher(htmlString: String) -> [String] {
        return []
    }
    
    private func parseWithKannaSyllabus(htmlString: String) -> [String] {
        return [rawInput]
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
            print("parseWithKannaDescription done  \(desc[0])")
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
