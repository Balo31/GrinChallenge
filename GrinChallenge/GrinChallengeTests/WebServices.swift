//
//  WebServices.swift
//  
//
//  Created by Stephane Gardon on 2/18/19.
//

import XCTest
@testable import GrinChallenge

class WebServices: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
            GrinWebServicios.sharedInstance.getDevices(
                verHud: true,
                viewController: nil,
                Success: { data in
                    
            }, Error: {})
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
