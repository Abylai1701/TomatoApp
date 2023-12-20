import Foundation

public protocol Parser {
    func parse<T: Decodable>(data: Data?, response: URLResponse?, error: Error?) -> (Result<T>, Int)
}

public class CustomParser: Parser {
    public init() {}

    public func parse<T>(data: Data?, response: URLResponse?, error: Error?) -> (Result<T>, Int) where T : Decodable {
        if let error = error {
            return (.failure(error.localizedDescription), 400)
        }
        guard let response = response as? HTTPURLResponse else { return (.failure("Response is not in HTTPResponse format"), 400)}
        switch response.statusCode {
        case 200:
            guard let data = data else { return (.failure(NetworkResponse.noData.rawValue), response.statusCode) }
            checkForJson(data)
            return decode(data,
                          statusCode: response.statusCode)
        case 201...499:
            guard let data = data else { return (.failure(NetworkResponse.noData.rawValue), response.statusCode) }
            if response.statusCode == 401 {
                return (.failure(NetworkResponse.authenticationError.rawValue),
                              statusCode: response.statusCode)
            }

            checkForJson(data)
            
            return decode(data,
                          statusCode: response.statusCode)
        case 300...399:
            return (.failure(NetworkResponse.redirect.rawValue), response.statusCode)
        case 500...501:
            guard let data = data else { return (.failure(NetworkResponse.noData.rawValue), response.statusCode) }
            let jsonString = String(data: data, encoding: .utf8)!
            print("JSONSTRING: ", jsonString)
            return (.failure(NetworkResponse.internalServerError.rawValue), response.statusCode)
            
        case 600:
            return (.failure(NetworkResponse.outdated.rawValue), response.statusCode)
        default:
            return (.failure(NetworkResponse.failed.rawValue), response.statusCode)
        }
    }

    private func decode<T: Decodable>(_ data: Data,
                                      statusCode: Int) -> (Result<T>, Int) {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(T.self, from: data)
            return (Result.success(response), statusCode)
        } catch {
            if T.self == String.self, let message = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? String {
                return (Result.success(message as! T), statusCode)
            } else if let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? T {
                return (Result.success(response), statusCode)
            }
            print(error)
            return (.failure("Ошибка с сервером: \(error)"), statusCode)
        }
    }

   

    private func checkForJson(_ data: Data) -> Void {
        do {
            let json  = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print(json)
        } catch {
            print("Error json: ", error.localizedDescription)
        }
    }
}
