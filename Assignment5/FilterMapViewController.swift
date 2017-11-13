//
//  FilterMapViewController.swift
//  Assignment5
//
//  Created by Kimaya Desai on 11/12/17.
//  Copyright © 2017 SDSU. All rights reserved.
//

import UIKit
import Alamofire

class FilterMapViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    
     var countryArray: Array<String> = [""]
    
    @IBOutlet var countrySelected: UILabel!
    @IBOutlet var countryFilter: UIPickerView!
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryArray[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)  {
        
        
        pickerView.reloadAllComponents()
        
        countrySelected.text = countryArray[row]
    }


    @IBAction func filterPressed(_ sender: AnyObject) {
        
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destin : MapUsers = segue.destination as! MapUsers
        destin.countryValue = countrySelected.text!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        countryFilter.reloadAllComponents()
        if countryFilter != nil {
            countryFilter.delegate = self
            countryFilter.dataSource = self
        }
        
        Alamofire.request("https://bismarck.sdsu.edu/hometown/countries") .validate()
            .responseJSON { response in switch response.result { case .success:
                if let JSON = response.result.value {
                    let jsonObject = JSON as! NSArray
                    self.countryArray = jsonObject as! Array<String>
                    self.countryFilter.reloadAllComponents()
                }
            case .failure(let error):
                print(error) }
        }
      
    }

    
    

    

}
