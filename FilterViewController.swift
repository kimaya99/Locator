//
//  FilterViewController.swift
//  
//
//  Created by Kimaya Desai on 11/10/17.
//

import UIKit
import Alamofire

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var filter = [AnyObject]()
    var nameToDisplay = ""
    var yearToDisplay = ""

    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    
    @IBOutlet var filterTable: UITableView!
    
    override func viewDidLoad() {

     super.viewDidLoad()
     secondLabel.text = nameToDisplay
     yearLabel.text = yearToDisplay
     Alamofire.request("http://bismarck.sdsu.edu/hometown/users?country=\(nameToDisplay)&year=\(yearToDisplay)") .validate()
            .responseJSON { response in switch response.result { case .success:
                let result = response.result
                if let abc = result.value as? Array<Any>{
                    self.filter = abc as [AnyObject]
                    self.filterTable.reloadData()
                }
            case .failure(let error):
                print(error) }
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = filterTable.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as? FilterTableViewCell
        let title1 = filter[indexPath.row]["nickname"]
        let cityName1 = filter[indexPath.row]["city"]
        let stateName1 = filter[indexPath.row]["state"]
        let yearName1 = filter[indexPath.row]["year"]
        
        cell?.nickLabel.text = title1 as? String
        cell?.cityme.text = cityName1 as? String
        cell?.stateLab.text = stateName1 as? String
        cell?.yearLab.text = String(yearName1 as! Int)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filter.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
}
