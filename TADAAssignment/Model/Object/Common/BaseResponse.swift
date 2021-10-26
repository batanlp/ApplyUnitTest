//
//  BaseResponse.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 11/10/2021.
//

class BaseResponse<T: Codable>: Codable {
    let status: String?
    let message: String?
    let data: T?
}
