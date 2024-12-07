//
//  DetailsPageViewModel.swift
//  StayConnected
//
//  Created by Giorgi Amiranashvili on 07.12.24.
//

import Foundation

class DetailsPageViewModel  {
    
    var url = URL(string: "DummyData")
   
     func postAcceptStatus(id:Int, text: String, isAccepted: Bool) {
        if isAccepted {
             url = URL(string: "https://h5ck35.pythonanywhere.com/api/answers/{\(id)}/accapt")!
        } else {
             url = URL(string: "https://h5ck35.pythonanywhere.com/api/answers/{\(id)}/reject")!
        }
        let requestBody: [String: Any] = [
            "id": id,
            "text": text,
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            print("Error serializing JSON")
            return
        }
        
        guard let token = KeychainService.retrieve(for: "authToken") else {
            
            return
        }
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                print("Request successful!")
            } else {
                print("Server error or unexpected response")
            }

            if let data = data {
                if let responseObject = try? JSONSerialization.jsonObject(with: data) {
                    print("Response: \(responseObject)")
                } else {
                    print("Unable to parse response")
                }
            }
        }

        task.resume()
    }
    }



