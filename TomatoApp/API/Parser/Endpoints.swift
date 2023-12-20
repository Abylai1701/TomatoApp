import Foundation

enum Endpoints: EndpointType {
    
    case get(url: String, parameters: Parameters?)
    case post(url: String, parameters: Parameters?, urlPamaters: Parameters?)
    case multipartFormData(url: String, parameters: Parameters?)
    case delete(url: String, parameters: Parameters?)
    case put(url: String, parameters: Parameters?, urlParameters: Parameters?)

    var baseUrl: URL {
        get { return URL(string: "\(API.prodURL)/api/")!}
        set{}
    }
    
    var path: String {
        switch self {
        case .get(let url, _):
            return url
        case .post(let url, _, _):
            return url
        case .multipartFormData(let url, _):
            return url
        case .delete(let url, _):
            return url
        case .put(let url, _, _):
            return url
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .post(_, _, _):
            return .post
        case .multipartFormData(_, _):
            return .post
        case .delete(_, _):
            return .delete
        case .put(_, _, _):
            return .put
        default:
            return .get
        }
    }

    var task: HTTPTask {
        var headers: HTTPHeaders = [:]
        var urlParameters: Parameters = [:]
        var bodyParameters: Parameters = [:]
        
        if UserManager.shared.getAccessToken() != nil {
            print("TOKEN", UserManager.shared.getAccessToken() ?? "")
            headers["Authorization"] = "Bearer \(UserManager.shared.getAccessToken() ?? "")"
//            headers["version"] = "2"
        }
        
        switch self {
        case .get(_, let parameters):
            if let params = parameters {
                urlParameters = params
            }
            
            print("QUERY_PARAMETERS", urlParameters)
            print("BODY_PARAMETERS", bodyParameters)
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                urlParameters: urlParameters,
                                                additionalHeaders: headers)
        case .post(_, let parameters, let qParameters):
            
            if let params = parameters {
                bodyParameters = params
            }
            
            print("QUERY_PARAMETERS", urlParameters)
            print("BODY_PARAMETERS", bodyParameters)
            return .requestParametersAndHeaders(bodyParameters: bodyParameters,
                                                urlParameters: qParameters,
                                                additionalHeaders: headers)
        case .put(_, let parameters, let qParameters):
            
            if let params = parameters {
                bodyParameters = params
            }
            
            print("QUERY_PARAMETERS", urlParameters)
            print("BODY_PARAMETERS", bodyParameters)
            return .requestParametersAndHeaders(bodyParameters: bodyParameters,
                                                urlParameters: qParameters,
                                                additionalHeaders: headers)
        case let .multipartFormData(_, parameters):
            if let params = parameters {
                bodyParameters = params
            }
            
            print("QUERY_PARAMETERS", urlParameters)
            print("BODY_PARAMETERS", bodyParameters)
            return .multipartFormData(bodyParameters: bodyParameters,
                                      urlParameters: nil,
                                      additionalHeader: headers)
         case let .delete(_, parameters):
            if let params = parameters {
                urlParameters = params
            }
            
            print("QUERY_PARAMETERS", urlParameters)
            print("BODY_PARAMETERS", bodyParameters)
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                urlParameters: urlParameters,
                  
                                                additionalHeaders: headers)
        }

    }


}
