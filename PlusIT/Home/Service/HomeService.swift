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

class SessionManager {
    func rx_request() -> Observable<(HTTPURLResponse, SwiftyJSON.JSON)> {
        return Observable.create{ observer in
            let baseURLPath = "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products"
            print(baseURLPath)
            
            guard let url = URL(string: baseURLPath) else {
                observer.onError(NSError())
                return Disposables.create()
            }
            let urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
            
            // request
            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
                if let err = error {
                    debugPrint("Erro na requisição = \(err.localizedDescription)")
                    observer.onError(error ?? NSError())
                } else {
                    
                    let httpResponse = response as? HTTPURLResponse
                    debugPrint("URLResponse da requisição = \(httpResponse!)")
                    var json: SwiftyJSON.JSON?
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        json = JSON(jsonObject)
                    } catch {
                        observer.onError(NSError())
                    }
                    if let js = json {
                        debugPrint("JSON de retorno = \(js)")
                        observer.onNext((httpResponse!, json!))
                        observer.onCompleted()
                    }
                    observer.onError(NSError())
                }
            })
            task.resume()
            
            return Disposables.create()
        }
    }
}
