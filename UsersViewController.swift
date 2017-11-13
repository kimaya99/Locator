//
//  UsersViewController.swift
//  
//
//  Created by Kimaya Desai on 11/9/17.
//

import UIKit
import Alamofire

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var array = [AnyObject]()
    @IBOutlet var tabView: UITableView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request("https://bismarck.sdsu.edu/hometown/users") .validate()
            .responseJSON { response in switch response.result { case .success:
                let result = response.result
                if let abc = result.value as? Array<Any>{
                    self.array = abc as [AnyObject]
                    self.tabView.reloadData()
                }
            case .failure(let error):
                print(error) }
        }
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? UserTableViewCell
        let title = array[indexPath.row]["nickname"]
        let cityName = array[indexPath.row]["city"]
        let stateName = array[indexPath.row]["state"]
        let yearName = array[indexPath.row]["year"]
   
        cell?.sampleLabel.text = title as? String
        cell?.city.text = cityName as? String
        cell?.state.text = stateName as? String
        cell?.yearC.text = String(yearName as! Int)

        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
