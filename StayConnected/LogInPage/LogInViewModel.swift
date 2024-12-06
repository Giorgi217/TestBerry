//
//  LogInViewModel.swift
//  StayConnected
//
//  Created by Giorgi Amiranashvili on 30.11.24.
//

import Foundation
import Security

class LogInViewModel {
    
    func logIn(email: String, password: String, completion: @escaping (Bool, String) -> Void) {
        let url = URL(string: "https://h5ck35.pythonanywhere.com/api/token/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error:", error ?? "Unknown error")
                completion(false, "An error occurred: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let responseDict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                if let token = responseDict["access"] as? String {
                    if KeychainService.delete(for: "authToken") {
                        print("keychain data deleted")
                    }
                    
                    if KeychainService.save(token, for: "authToken") {
                        print("Token saved to Keychain")
                        completion(true, "Log in successful")
                    } else {
                        completion(false, "Failed to save token")
                    }
                    
                } else {
                    completion(false, "Incorrect email or password")
                }
            }
        }
        task.resume()
    }
}



