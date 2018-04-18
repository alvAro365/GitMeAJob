//
//  DataModel.swift
//  Created by Alvar Aronija on 18/04/2018.
//  Copyright © 2018 Alvar Aronija. All rights reserved.
//

import Foundation

struct Job: Codable {
    let createdAt: String
    let title: String
    let location: String
    let company: String
    let type: String
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case title
        case location
        case company
        case type
        case url
    }
}

extension Job {
    enum Result<Value> {
        case success(Value)
        case failure(Error)
    }
    static func getJobs(description: String, location: String, fullTime: Bool, completion: ((Result<[Job]>) -> Void)?) {
        var urlComponents = URLComponents(string: "https://jobs.github.com/positions.json")!
        let queryItemDescription = URLQueryItem(name: "description", value: description)
        let queryItemLocation = URLQueryItem(name: "location", value: location)
        let queryIsFullTime = URLQueryItem(name: "full_time", value: "true")
        
        if fullTime == true {
            urlComponents.queryItems = [queryItemDescription, queryItemLocation, queryIsFullTime]
        } else {
            urlComponents.queryItems = [queryItemDescription, queryItemLocation]
        }
        guard let url = urlComponents.url else {
            fatalError("Creating URL failed")
        }
        print("The URL is: \(url)")
        let task = URLSession.shared.dataTask(with: url) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    completion?(.failure(error))
                } else if let jsonData = responseData {
                    let decoder = JSONDecoder()
                    do {
                        let jobs = try decoder.decode([Job].self, from: jsonData)
                        print(jobs)
                        completion?(.success(jobs))
                    } catch {
                        completion?(.failure(error))
                    }
                } else {
                    print("Json parsing failed")
                }
            }
        }
        task.resume()
    }
}

// Call following method on viewController
//
/*
Job.getJobs(description: titleLabel.text, location: locationLabel.text, fullTime: true or false) { (result) in
    switch result {
    case .success(let jobs):
        // self.jobs is an array of Job structs
        self.jobs = jobs
        // TODO: Find better solutions for reloading data
        self.jobsTableView.reloadData()
    case .failure(let error):
        fatalError("error: \(error.localizedDescription)")
    }
}
*/
