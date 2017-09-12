//
//  ViewController.swift
//  APIDemo
//
//  Created by appinventiv on 11/09/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache",
            "postman-token": "6b1669f2-56f4-e0de-f92e-abd1b488bf21"
        ]
        
        let postData = NSMutableData(data: "Name=Sabhya".data(using: String.Encoding.utf8)!)
        postData.append("&Id=22".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://httpbin.org/post")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                let responseData = String(data:data!, encoding: .utf8)!
                print(responseData)
                let json = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 0))
                
                guard let dict = json as? [String:Any] else {
                    return
                }
                
                guard let form = dict["form"] as? [String:Any] else { return }
                guard let id = form["Id"] as? String else { return }
                
                print("My Id is \(id)")
            }

            
        })
        
        dataTask.resume()
    }

            


}


