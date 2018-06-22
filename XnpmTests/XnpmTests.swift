//
//  XnpmTests.swift
//  XnpmTests
//
//  Created by Joss Manger on 6/22/18.
//  Copyright © 2018 Joss Manger. All rights reserved.
//

import XCTest
@testable import Xnpm

class XnpmTests: XCTestCase {
    
   let testURL = URL(string: "file:///Users/josmange/Documents/dev/100326-biogen-govt-affairs-widget/package.json")
    var pa:PackageAnalyser!
    
    override func setUp() {
        super.setUp()
        print(testURL!)
        pa = PackageAnalyser(packageUrl: testURL!)
        pa.processDict()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        pa = nil
        super.tearDown()
    }
    
    func testDynamicVars() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssert(pa.packageTitle=="100326-biogen-govt-affairs-widget", "package title set incorrectly")
        XCTAssert(pa.author=="Joss Manger joss.manger@langlandusa.com", "package title set incorrectly")
        XCTAssert(pa.version=="1.0.0", "package version set incorrectly")
        XCTAssert(pa.packageDescription=="Interactive 3D Map built with THREE.js", "package title set incorrectly")
        XCTAssert(pa.repoLink.absoluteString=="git@bitbucket.org:langland/100326-biogen-govt-affairs-widget.git", "package repoLink set incorrectly")
        XCTAssert(pa.license=="MIT", "package license set incorrectly")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        pa = nil
        self.measure {
            pa = PackageAnalyser(packageUrl: testURL)
            // Put the code you want to measure the time of here.
        }
    }
    
}
