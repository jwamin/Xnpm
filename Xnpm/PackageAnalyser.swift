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
    var valid:Bool = true
    var error:NSError?
    dynamic var packageTitle:String!
    dynamic var author:String!
    dynamic var version:String!
    dynamic var license:String!
    dynamic var packageDescription:String!
    dynamic var repoLink:URL!
    dynamic var scripts:NSArray!
    dynamic var gitBranch:String!
    
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
                print("bad form error")
                self.error = error
                self.valid = false
            }
            
        } catch {
            
            print("didnt work")
            
        }
        
    }
    
    func processDict(){
        
        
        
        var dict = dictionary["scripts"] as! [String:String]
            dict.removeValue(forKey: "postinstall")
        scripts = NSArray(array: Array(dict.keys))
        
        packageTitle = dictionary["name"] as? String ?? "none"
        author = dictionary["author"] as? String ?? "none"
        license = dictionary["license"] as? String ?? "none"
        version = dictionary["version"] as? String ?? "none"
        packageDescription = dictionary["description"] as? String ?? "none"
        if let repository = dictionary["repository"] as? [String:String]{
            repoLink = URL(string: repository["url"]!)
        }
        
        
//        print(packageTitle)
//        print(author)
//        print(license)
//        print(version)
//        print(packageDescription)
//        print(repoLink)
//        print(scripts)
        
        
    }
    
    func returndict()->[String:Any]{
        return dictionary
    }
    
    func setBranch(branchString:String){
        self.gitBranch = branchString
    }

    
}
