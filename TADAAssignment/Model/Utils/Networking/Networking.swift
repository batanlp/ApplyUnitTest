//
//  Networking.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 11/10/2021.
//

import UIKit

class Networking {
    
    private let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func addDefauldHeader(url: String) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // Adding more if needed
        
        return request
    }
    
    func performNetworkTask<T: Codable>(endpoint: ApiServices,
                                    type: T.Type?,
                                    completion: ((_ response: T?) -> ())?,
                                    errorCompletion: ((_ messages: String?) -> ())?) {
        
        var urlString = "\(endpoint.baseURL)\(endpoint.path)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        var request = self.addDefauldHeader(url: urlString)
        request.httpMethod = endpoint.method
        
        if (endpoint.header_auth != "") {
            request.addValue(endpoint.header_auth, forHTTPHeaderField: "Authorization")
        }
        
        LogManager.shared.logConsole(msg: "========")
        LogManager.shared.logConsole(msg: "URL: \(urlString)")
        LogManager.shared.logConsole(msg: "Method: \(endpoint.method)")
        LogManager.shared.logConsole(msg: "Header:")
        print(request.allHTTPHeaderFields!)
        
        if (endpoint.method != "GET") {
            let jsonData = try? JSONSerialization.data(withJSONObject: endpoint.parameters)
            request.httpBody = jsonData
            LogManager.shared.logConsole(msg: "Body: \(String(data: request.httpBody!, encoding: .utf8)!)")
        }
       
        let urlSession = session.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                errorCompletion?("Fail request")
                return
            }
            guard let data = data else {
                errorCompletion?("Data error")
                return
            }
        
            let responseData = String(data: data, encoding: String.Encoding.utf8)
            LogManager.shared.logConsole(msg: "Json data for: \(urlString)")
            print(responseData!)
            
            let response = Response(results: data)
            guard let decoded = response.decode(type!) else {
                return (errorCompletion?("Unknown Error"))!
            }
            completion?(decoded)
        }
        urlSession.resume()
    }
}
