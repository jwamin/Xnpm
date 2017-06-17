//
//  PackageAnalyser.swift
//  Xnpm
//
//  Created by Joss Manger on 6/17/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import Cocoa

class PackageAnalyser: NSObject {
    
    var url:URL!
    var dictionary:[String:Any]!
    
    init(packageUrl:URL) {
        super.init()
        
        url = packageUrl

        processPackage()
    }
    
    func processPackage(){
        
        do{
            
            let str = try String(contentsOf: url, encoding: .utf8)
            let data = str.data(using: .utf8)!
            
            do {
                
                let parsedData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                dictionary = parsedData                 
                
            } catch let error as NSError {
                
                print(error)
                
            }
            
        } catch {
            
            print("didnt work")
            
        }
        
    }
    
    func returndict()->[String:Any]{
        return dictionary
    }
    
    //        do{
    //            let data = try NSData(contentsOfFile: url.absoluteString, options: .uncached){
    //                do {
    //
    //                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
    //                    dictionary = parsedData as! [String:Any]
    //
    //                    print(dictionary)
    //
    //                } catch let error as NSError {
    //                    print(error)
    //                }
    //            }
    //    }
    
}
