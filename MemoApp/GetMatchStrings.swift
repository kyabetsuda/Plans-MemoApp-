//
//  GetMatchString.swift
//  MemoApp
//
//  Created by 津田準 on 2018/07/01.
//  Copyright © 2018 津田準. All rights reserved.
//

import Foundation

class GetMatchStrings {
    
    //渡した文字列から、渡した正規表現にマッチする文字列を検索して、配列に格納する
    func getMatchStrings(targetString: String, pattern: String) -> [String] {
        
        var matchStrings:[String] = []
        
        do {
            
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let targetStringRange = NSRange(location: 0, length: (targetString as NSString).length)
            
            let matches = regex.matches(in: targetString, options: [], range: targetStringRange)
            
            for match in matches {
                
                // rangeAtIndexに0を渡すとマッチ全体が、1以降を渡すと括弧でグループにした部分マッチが返される
                let range = match.range(at: 0)
                let result = (targetString as NSString).substring(with: range)
                
                matchStrings.append(result)
            }
            
            return matchStrings
            
        } catch {
            print("error: getMatchStrings")
        }
        return []
    }
    
}
