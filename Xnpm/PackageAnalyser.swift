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
    
    dynamic var packageTitle:String!
    dynamic var author:String!
    dynamic var version:String!
    dynamic var license:String!
    dynamic var packageDescription:String!
    dynamic var repoLink:URL!
    dynamic var scripts:NSArray!
    
    
    init(packageUrl:URL?) {
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
                //print(dictionary)
                processDict()
                
            } catch let error as NSError {
                
                print(error)
                
            }
            
        } catch {
            
            print("didnt work")
            
        }
        
    }
    
    func processDict(){
        
        
        
        let arr = dictionary["scripts"] as! [String:String]
        scripts = NSArray(array: Array(arr.keys))
        
        packageTitle = dictionary["name"] as! String
        author = dictionary["author"] as! String
        license = dictionary["license"] as! String
        version = dictionary["version"] as! String
        packageDescription = dictionary["description"] as! String
        let repository = dictionary["repository"] as! [String:String]
        repoLink = URL(string: repository["url"]!)
        
        print(packageTitle)
        print(author)
        print(license)
        print(version)
        print(packageDescription)
        print(repoLink)
        print(scripts)
        
        
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
