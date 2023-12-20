//
//  EndpointType.swift
//  NetworkManager
//
//  Created by Yerassyl Zhassuzakhov on 4/30/19.
//  Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String: String]
typealias Parameters = [String: Any]

protocol EndpointType {
    var baseUrl: URL { get set}
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        urlParameters: Parameters?,
        additionalHeaders: HTTPHeaders?)
    case multipartFormData(bodyParameters: Parameters?, urlParameters: Parameters?, additionalHeader: HTTPHeaders?)
}

enum NetworkError: String, Error {
    case parametersNil = "parameters nil"
}

protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

class URLParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { return }
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                if let values = value as? [String] {
                    for i in values {
                        let queryItem = URLQueryItem(name: "\(key)[]", value: "\(i)")
                        urlComponents.queryItems?.append(queryItem)
                    }
                }
                else {
                    let queryItem = URLQueryItem(name: key, value: "\(value)")
                    urlComponents.queryItems?.append(queryItem)
                }
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        print(urlRequest, "PATH")
    }
}

class JSONParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            var params: [String: Any] = [:]
            for (key, values) in parameters {
                if let values = values as? [Loopable] {
                    var arrayOfVal: [[String: Any]] = []
                    for properties in values {
                        arrayOfVal.append(try properties.allProperties())
                    }
                    params[key] = arrayOfVal
                }
                else if let values = values as? Loopable {
                    params[key] = try values.allProperties()
                }
                else {
                    params[key] = values
                }
            }
            let jsonData = try JSONSerialization.data(withJSONObject: params, options: [])
            urlRequest.httpBody = jsonData
        } catch {
            throw NetworkError.parametersNil
        }
    }
}
