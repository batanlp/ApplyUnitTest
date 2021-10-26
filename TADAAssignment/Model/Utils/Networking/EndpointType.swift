//
//  EndpointType.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 11/10/2021.
//

import UIKit

protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var method: String { get }
    var parameters: Dictionary<String, Any> { get }
    var header_auth: String { get }
}
