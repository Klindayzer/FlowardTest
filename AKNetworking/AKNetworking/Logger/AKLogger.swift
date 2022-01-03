/*
 *	AKLogger.swift
 *	AKNetworking
 *
 *	Created by Klindayzer on 21/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */

protocol AKLogger {
    
    var shouldLog: Bool { get }
    func logRequest(_ request: URLRequest?)
    func logResponse(_ response: HTTPURLResponse?, data: Data?, error: Error?)
    func logError<T>(_ error: T)
}

extension AKLogger {
    
    func logRequest(_ request: URLRequest?) {
        
        guard shouldLog else { return }
        
        print("\n - - - - - - - - - - REQUEST STARTS - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - - REQUEST ENDS - - - - - - - - - - \n") }
        
        guard let request = request else {
            print("\n - - - - - - - - - - NIL - - - - - - - - - - \n")
            return
        }
        
        print("\n - - - - - - - - - - CURL STARTS - - - - - - - - - - \n")
        print(request.cURL)
        print("\n - - - - - - - - - - CURL ENDS - - - - - - - - - - \n")
        
        if let urlAsString = request.url?.absoluteURL {
            print("URL: \(urlAsString)")
        }
        
        if let method = request.httpMethod {
            print("\nMethod: \(method)")
        }
        
        if let headerParams = request.allHTTPHeaderFields {
            print("\nHeader Params: ")
            print(headerParams)
        }
        
        if let body = request.httpBody {
            do {
                if let postParams = try JSONSerialization.jsonObject(with: body, options: .mutableContainers) as? [String: Any] {
                    print("\nPost Params: ")
                    print(postParams)
                }
            } catch let e {
                print("\nException: \(e.localizedDescription)")
            }
        }
    }
    
    func logResponse(_ response: HTTPURLResponse?, data: Data?, error: Error?) {
        
        guard shouldLog else { return }
        
        print("\n - - - - - - - - - - REPONSE STARTS - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - - REPONSE ENDS - - - - - - - - - - \n") }
        print("Status Code: \(response?.statusCode ?? 0)")
        print("Error: \(error.debugDescription)")
        
        guard let JSONString = data?.prettyPrintedJSONString else {
            print("Response: Empty")
            return
        }
        
        print("\nResponse: \n\(JSONString)")
    }
    
    func logError<T>(_ error: T) {
        
        guard shouldLog else { return }
        
        print("\n - - - - - - - - - - EXCEPTION STARTS - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - - EXCEPTION ENDS - - - - - - - - - - \n") }
        print("Error: \(error)")
    }
}

private extension URLRequest {
    
    /// Returns a cURL command for a request
    /// - return A String object that contains cURL command or "" if an URL is not properly initalized.
    var cURL: String {
        
        guard
            let url = url,
            let httpMethod = httpMethod,
            url.absoluteString.utf8.count > 0 else {
                return ""
            }
        
        var curlCommand = "curl \\\n"
        
        // URL
        curlCommand = curlCommand.appendingFormat(" '%@' \\\n", url.absoluteString)
        
        // HTTP Method
        curlCommand = curlCommand.appendingFormat(" -X %@ \\\n", httpMethod)
        
        // Headers
        let allHeadersFields = allHTTPHeaderFields!
        let allHeadersKeys = Array(allHeadersFields.keys)
        let sortedHeadersKeys  = allHeadersKeys.sorted(by: <)
        for key in sortedHeadersKeys {
            curlCommand = curlCommand.appendingFormat(" -H '%@: %@' \\\n", key, self.value(forHTTPHeaderField: key)!)
        }
        
        // HTTP body
        if let httpBody = httpBody, httpBody.count > 0 {
            let httpBodyString = String(data: httpBody, encoding: String.Encoding.utf8)!
            let escapedHttpBody = escapeAllSingleQuotes(httpBodyString)
            curlCommand = curlCommand.appendingFormat(" --data '%@' \\\n", escapedHttpBody)
        }
        
        return curlCommand
    }
    
    /// Escapes all single quotes for shell from a given string.
    private func escapeAllSingleQuotes(_ value: String) -> String {
        return value.replacingOccurrences(of: "'", with: "'\\''")
    }
}

private extension Data {
    
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return prettyPrintedString
    }
}

