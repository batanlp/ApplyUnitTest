//
//  MockURLSession.swift
//  TADAAssignmentTests
//
//  Created by Nguyen Ba Tan on 25/10/2021.
//

import Foundation

class MockSession: URLSession {
    
    var completionHandler: ((Data, URLResponse, Error) -> Void)?
    static var mockResponse: (data: Data?, URLResponse: URLResponse?, error: Error?)

    override class var shared: URLSession {
        return MockSession()
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.completionHandler = completionHandler
        return MockTask(response: MockSession.mockResponse, completionHandler: completionHandler)
    }
    
}

class MockTask: URLSessionDataTask {
    
    typealias Response = (data: Data?, URLResponse: URLResponse?, error: Error?)
    var mockResponse: Response
    let completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    init(response: Response, completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) {
        self.mockResponse = response
        self.completionHandler = completionHandler
    }
    
    override func resume() {
        completionHandler!(mockResponse.data, mockResponse.URLResponse, mockResponse.error)
    }
}
