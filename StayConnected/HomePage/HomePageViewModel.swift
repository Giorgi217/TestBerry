//
//  HomePageViewModel.swift
//  StayConnected
//
//  Created by Giorgi Amiranashvili on 01.12.24.
//

import Foundation

// Model to match the JSON structure
struct Tag: Codable {
    let id: Int
    let name: String
}

struct Answer: Codable {
    let id: Int
    let text: String
    let user: String
    let created_at: String
    let is_accepted: Bool
}

struct Question: Codable {
    let id: Int
    let user: String
    let user_id: Int
    let subject: String
    let text: String
    let tag_list: [Tag]
    let created_at: String
    let updated_at: String
    let views_count: Int
    let votes: Int
    let answers: [Answer]
    let slug: String
}


class HomePageViewModel {
    
    func addquestion(subject: String, text: String, tags: [String]) {
        let url = URL(string: "https://h5ck35.pythonanywhere.com/api/questions/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let token = KeychainService.retrieve(for: "authToken") else { return }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let parameters: [String: Any] = [
            "subject": subject,
            "text": text,
            "tags": tags
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error:", error ?? "Unknown error")
                return
            }
            if let responseDict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                print(responseDict)
            }
            print("done")
        }
        task.resume()
    }
    
    
    func getQuestions(completion: @escaping ([Question]?) -> Void) {
        let url = URL(string: "https://h5ck35.pythonanywhere.com/api/questions/")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        guard let token = KeychainService.retrieve(for: "authToken") else {
            completion(nil)
            return
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error:", error ?? "Unknown error")
                completion(nil)
                return
            }
            
            do {
                // Decode the JSON into an array of Question models
                let questions = try JSONDecoder().decode([Question].self, from: data)
                completion(questions)
            } catch {
                print("Decoding error: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func getTags(completion: @escaping ([Tag]?) -> Void) {
        let url = URL(string: "https://h5ck35.pythonanywhere.com/api/tags/top-tags")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        guard let token = KeychainService.retrieve(for: "authToken") else {
            completion(nil)
            return
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error:", error ?? "Unknown error")
                completion(nil)
                return
            }
            
            do {
                // Decode the JSON into an array of Question models
                let tags = try JSONDecoder().decode([Tag].self, from: data)
                completion(tags)
            } catch {
                print("Decoding error: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func addAnswear(text: String, questionid: Int) {
        let url = URL(string: "https://h5ck35.pythonanywhere.com/api/answers/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let token = KeychainService.retrieve(for: "authToken") else { return }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let parameters: [String: Any] = [
            "question": questionid,
            "text": text,
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error:", error ?? "Unknown error")
                return
            }
            if let responseDict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                print(responseDict)
            }
            print("done")
        }
        task.resume()
    }
}
