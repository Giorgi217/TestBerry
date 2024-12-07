//
//  SignUpViewModel.swift
//  StayConnected
//
//  Created by Giorgi Amiranashvili on 29.11.24.
//

import Foundation
import UIKit


class SignUpViewModel {
    
    func register(username: String, email: String, password: String, confirmPassword: String, completion: @escaping (Bool, String?) -> Void) {
        let url = URL(string: "https://164.90.165.135/api/register/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "username": username,
            "email": email,
            "password": password,
            "password_confirm": confirmPassword
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        let session = URLSession(configuration: .default, delegate: CustomSessionDelegate(), delegateQueue: nil)
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(false, "An error occurred: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if let responseDict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                if let tokens = responseDict["tokens"] as? [String: Any],
                   let accessToken = tokens["access"] as? String {
                    if KeychainService.delete(for: "authToken") {
                        print("keychain data deleted")
                    }
                    if KeychainService.save(accessToken, for: "authToken") {
                        print("Token saved to Keychain")
                        completion(true, "Log in successful")
                    }
                    completion(true, nil)
                } else {
                    // Handle error case
                    if let errorMessages = responseDict.compactMapValues({ $0 as? [String] }) as? [String: [String]],
                       let firstKey = errorMessages.keys.first,
                       let firstMessage = errorMessages[firstKey]?.first {
                        completion(false, firstMessage)
                    } else {
                        completion(false, "An unknown error occurred.")
                    }
                }
            } else {
                completion(false, "Unable to parse response from server.")
            }
        }
        
        task.resume()
    }
}
 
