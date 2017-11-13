//
//  MenuViewController.swift
//  
//
//  Created by Kimaya Desai on 11/9/17.
//

import UIKit
import Alamofire

class MenuViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var countryArray: Array<String> = [""]
    var year = (1970...2017).map { String($0) }
    
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var yearL: UITextField!
 
    @IBOutlet weak var countryPicker: UIPickerView!
    
    @IBAction func filterUsers(_ sender: UIButton) {
        performSegue(withIdentifier: "go", sender: self)
        
      
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! FilterViewController
        destVC.nameToDisplay = country.text!
        let destVC2 = segue.destination as! FilterViewController
        destVC2.yearToDisplay = yearL.text!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
         countryPicker.reloadAllComponents()
        if countryPicker != nil {
            countryPicker.delegate = self
            countryPicker.dataSource = self
        }

        Alamofire.request("https://bismarck.sdsu.edu/hometown/countries") .validate()
            .responseJSON { response in switch response.result { case .success:
                if let JSON = response.result.value {
                    let jsonObject = JSON as! NSArray
                    self.countryArray = jsonObject as! Array<String>
                    print(self.countryArray)
                     self.countryPicker.reloadAllComponents()
                }
            case .failure(let error):
                print(error) }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch component {
        case 0:
            return countryArray[row]
            
        case 1: return year[row]
        default: return "None"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0: return countryArray.count
        case 1: return year.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            country.text = countryArray[row]
        }
        if component == 1 {
            yearL.text = year[row]
        }
        
        pickerView.reloadAllComponents()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    

  

}
