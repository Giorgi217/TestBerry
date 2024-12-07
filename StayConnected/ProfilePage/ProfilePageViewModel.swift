//
//  ProfilePageViewModel.swift
//  StayConnected
//
//  Created by Giorgi Amiranashvili on 06.12.24.
//

import Foundation

class ProfilePageViewModel {
    
    func fetchProfile(completion: @escaping (Profile?, Error?) -> Void) {

            let url = URL(string: "https://164.90.165.135/api/profiles/my-profile/")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            guard let token = KeychainService.retrieve(for: "authToken") else {
                
                return
            }
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let session = URLSession(configuration: .default, delegate: CustomSessionDelegate(), delegateQueue: nil)
        
            let task = session.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    completion(nil, error)
                    print("Error:", error ?? "Unknown error")
                   
                    return
                }
                
                do {
                    // Decode the JSON into an array of Question models
                    let profile = try JSONDecoder().decode(Profile.self, from: data)
                    print(profile)
                    completion(profile, nil)
                  
                }
                catch {
                    print("vavavav")
                    completion(nil, error)
                }
            }
            
            task.resume()
        }
    }


