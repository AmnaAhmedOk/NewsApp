//
//  NetworkOperations.swift
//  NewsApp
//
//  Created by Amna on 11/19/20.
//  Copyright © 2020 Amna. All rights reserved.
//

import Foundation
class NetworkOperations {
    static let shared = NetworkOperations()
       private init() {}
    
     func performAPIRequset(urlString:String,handler:@escaping () -> Void){
        if let url = URL(string: urlString){
            var urlReq = URLRequest(url: url)
            urlReq.httpMethod = "GET"
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlReq) { (data, res, error) in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: AnyObject] {
                    if urlString == "https://newsapi.org/v2/everything?q=egypt&apiKey=ea476aa57e7d47dcbd3098afb1983bbd"{
                           GlobalVariables.shared.egyptArticales = responseJSON["articles"]  as! [AnyObject];
                    }
                    else if urlString == "https://newsapi.org/v2/everything?q=apple&apiKey=ea476aa57e7d47dcbd3098afb1983bbd"{
                        GlobalVariables.shared.appleArticales = responseJSON["articles"]  as! [AnyObject];
                    }
                    else if urlString == "https://newsapi.org/v2/everything?q=sports&apiKey=ea476aa57e7d47dcbd3098afb1983bbd"{
                                     GlobalVariables.shared.sportArticales = responseJSON["articles"]  as! [AnyObject];
                    }
                    else if urlString == "https://newsapi.org/v2/everything?q=bitcoins&apiKey=ea476aa57e7d47dcbd3098afb1983bbd"{
                                    GlobalVariables.shared.bitcoinsArticales = responseJSON["articles"]  as! [AnyObject];
                                     }
             
                }
                handler()

            }
            
            task.resume()
        }
    }
}
