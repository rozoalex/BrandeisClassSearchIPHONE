//
//  Attribute.swift
//  BrandeisClassSearchIPHONE
//
//  Created by Yuanze Hu on 1/12/17.
//  Copyright © 2017 Yuanze Hu. All rights reserved.
//

enum Attribute {
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


