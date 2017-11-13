//
//  ViewController.swift
//  Assignment5
//
//  Created by Kimaya Desai on 11/3/17.
//  Copyright © 2017 SDSU. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // String get
        
     /*   Alamofire.request("https://bismarck.sdsu.edu/hometown/users").responseString { response in guard response.error == nil else {
            print("Error")
            return }
            guard let status = response.response?.statusCode, status == 200 else {
                // Find out what went wrong
                return }
            if let utf8Text = response.result.value { print(utf8Text)
            } }
        */
        
        // JSON get
        
        Alamofire.request("https://bismarck.sdsu.edu/hometown/users") .validate()
            .responseJSON { response in switch response.result { case .success:
                if let JSON = response.result.value {
                    let jsonObject = JSON as! NSArray
                    print("JSON: \(jsonObject)")
                }
            case .failure(let error):
                print(error) }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

