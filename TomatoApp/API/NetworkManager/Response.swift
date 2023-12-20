//
//  GenericResponse.swift
//  Inviterkz
//
//  Created by Yerassyl Zhassuzakhov on 5/13/19.
//  Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

class Response<T: Decodable>: Decodable {
    let message: String?
    let data: T?
    let statusCode: Int?
    let success:Bool?
}

class TempResponse<T: Decodable>: Decodable {
    let message: String
    let data: T?
    let statusCode: Int?
    let success:Bool?
}

struct Pagination<T: Codable>: Codable {
    let page: Int
    let data: [T]
    let count: Int
    let limit: Int
    let offset: Int
    let pages: Int
    
}

