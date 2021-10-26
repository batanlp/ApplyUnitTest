//
//  MockURLProtocol.swift
//  TADAAssignmentTests
//
//  Created by Nguyen Ba Tan on 22/10/2021.
//

import Foundation

class MockURLProtocol: URLProtocol {
    static var stub: Data?
    static var error: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let error = MockURLProtocol.error {
            self.client?.urlProtocol(self, didFailWithError: error)
        }
        else {
            self.client?.urlProtocol(self, didLoad: MockURLProtocol.stub ?? Data())
        }
    
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
    }
}
