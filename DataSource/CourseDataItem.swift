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



let attributeList = [Attribute.NAME,Attribute.BOOK,Attribute.BLOCK,Attribute.TIME,Attribute.TEACHER,Attribute.SYLLABUS,Attribute.DESCRIPTION,Attribute.TERM]


class CourseDataItem {
    let Error = "Error"
    var attribute: Attribute
    var rawInput: String
    var resultList = [String]()
    var isDone = false
    
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
    
    public func appendRawInput(input: String)  {
        self.rawInput = rawInput + "\n\(input)"
        print("appended raw Inp: \(self.rawInput)")
    }
    
    
    //the method called from outside to start downloading stuffs
    public func execute(){
        if attribute == .BOOK || attribute == .DESCRIPTION || attribute == .TEACHER || attribute == .SYLLABUS{
            let queue = DispatchQueue(label: attribute.getHeader())
            queue.async {
                let start = Date()
                print("new Background thread for \(self.attribute.getHeader())\n")
                self.doFetchWithAlamofire(urlString: self.rawInput)

                print("Thread for \(self.attribute.getHeader()) is done.\nTakes \(start.timeIntervalSinceNow)")
                DispatchQueue.main.async {
                    print("switching back to main")
                    switch self.attribute{
                    case .DESCRIPTION:
                        print("refreshDescCell in courseDataItem")
                        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.refreshDescCell()
                        break
                    case .TEACHER:
                        
                        break
                    case .SYLLABUS:
                        
                        break
                    
                    case .BOOK:
                        
                        break
                    default:
                        
                        break
                    }
                    
                }
            }
            queue.resume()
            
            
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
                self.resultList = self.setResult(htmlString: html)
            }else{
                print("url not working, url: \(urlString)")
            }
        })
        isDone = true
        
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
