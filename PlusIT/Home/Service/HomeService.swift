//
//  HomeService.swift
//  PlusIT
//
//  Created by Diego Rodrigues Abdala Uthman on 28/02/22.
//

import UIKit
import RxSwift
import SwiftyJSON

class HomeService {
    
    func fetchData(completion: @escaping (Response) -> Void) {
        let url = URL(string: "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let decoder = JSONDecoder()
            if let responseMessage = try? decoder.decode(Response.self, from: data ?? Data()) {
                do {
                    DispatchQueue.main.async {
                        completion(responseMessage)
                    }
                }
            }
        }
        task.resume()
    }
}
