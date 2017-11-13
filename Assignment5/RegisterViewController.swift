//
//  RegisterViewController.swift
//  Assignment5
//
//  Created by Kimaya Desai on 11/6/17.
//  Copyright © 2017 SDSU. All rights reserved.
//

import UIKit
import Alamofire
import MapKit



class RegisterViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate, UITextFieldDelegate, VCFinalDelegate {
    func finishPassing(string string1: String,string2 :String) {
        print(string1)
        latitude.text = string2
        longitude.text = string1
        print(string2)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LocationViewController {
            destination.delegate = self
            if let abc = latitude.text {
                var oprt = latitude.text!
                 destination.latitudeL = oprt
            }
            else{
                 destination.latitudeL = "32.955"
            }
            
            if let abc = latitude.text {
                destination.longitudeL = longitude.text!
            }
            else{
                destination.longitudeL = "-117.2459"
            }
        
        }
    }
    
    
    let numberToolbar: UIToolbar = UIToolbar()
    public var x: Array<String> = [""]
    public var y: Array<String> = [""]
    public var year = [1970 ... 2017]

    var labelText1 = ""
    var labelText2 = ""
    
    @IBOutlet weak var nickName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var longitude: UITextField!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var city: UITextField!
   
    @IBOutlet weak var yearX: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    var country = "Germany"
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        let toolBar: UIToolbar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolBar.setItems([doneButton1],animated:false)
        
        yearX.inputAccessoryView = toolBar
        
        let tooBar: UIToolbar = UIToolbar()
        tooBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        let minusButton = UIBarButtonItem(title: "-", style: .plain, target: self, action: #selector(toggleMinus))
        tooBar.setItems([doneButton,minusButton],animated:false)
        
        longitude.inputAccessoryView = tooBar
        
        let tooBar2: UIToolbar = UIToolbar()
        tooBar2.sizeToFit()
        let doneButton2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        let minusButton2 = UIBarButtonItem(title: "-", style: .plain, target: self, action: #selector(toggleMinus2))
        tooBar2.setItems([doneButton2,minusButton2],animated:false)
        
        latitude.inputAccessoryView = tooBar2
        
        let center:  NotificationCenter = NotificationCenter.default;
         center.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
         center.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
         yearX.keyboardType = UIKeyboardType.numberPad
         latitude.keyboardType = UIKeyboardType.decimalPad
         longitude.keyboardType = UIKeyboardType.decimalPad

         longitude.text = labelText1
         latitude.text = labelText2
    
         if pickerView != nil {
            pickerView!.delegate = self
            pickerView!.dataSource = self
         }

        runGetRequest1()
      
        
        
    }
    
    @IBAction func calculateLatLong(_ sender: Any) {
        let locator = CLGeocoder()
        print(city)
        locator.geocodeAddressString("\(city.text!),\(stateLabel.text!),\(countryLabel.text!)")
        { (placemarks, errors) in
            if let place = placemarks?[0] {
                
                if let opt1 = place.location?.coordinate.latitude {
                    var opt2 = place.location?.coordinate.latitude
                    print(opt2!)
                    
                     self.latitude.text! = String(describing: opt2!)
                }
                else{
                    
                    let alert = UIAlertController(title:"Try Again",message:"Null Value", preferredStyle : .alert)
                    let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                    alert.addAction(closeAction)
                    self.present(alert,animated: true,completion: nil)
                    
                }
                if let opt3 = place.location?.coordinate.longitude {
                    var opt4 = place.location?.coordinate.longitude
                    print(opt4!)
                    
                    self.longitude.text! = String(describing: opt4!)
                }
                
                else{
                    let alert = UIAlertController(title:"Try Again",message:"Null Value", preferredStyle : .alert)
                    let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                    alert.addAction(closeAction)
                    self.present(alert,animated: true,completion: nil)
                }
          
            } else {
                let alert = UIAlertController(title:"Try Again",message:"Place does not exist", preferredStyle : .alert)
                let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                alert.addAction(closeAction)
                self.present(alert,animated: true,completion: nil)
                print( errors! )
                
            } }
    }
    @IBAction func setLocation(_ sender: Any) {
       
        performSegue(withIdentifier: "go", sender: nil)
        
       
    }
    

    
    
    
    func runGetRequest1(){
        Alamofire.request("https://bismarck.sdsu.edu/hometown/countries") .validate()
            .responseJSON { response in switch response.result { case .success:
                if let JSON = response.result.value {
                    let jsonObject = JSON as! NSArray
                    self.x = jsonObject as! Array<String>
                    print(self.x)
                    self.pickerView.reloadAllComponents()
                    
                    
                }
            case .failure(let error):
                print(error) }
        }
    }
    
    func runGetRequest2(){
        Alamofire.request("https://bismarck.sdsu.edu/hometown/states?country=\(self.country)") .validate()
            .responseJSON { response in switch response.result { case .success:
                if let JSON = response.result.value {
                    let jsonObject = JSON as! NSArray
                    self.y = jsonObject as! Array<String>
                    print(self.y)
               
                    print(self.country)
                    self.countryLabel.text = self.country
                    self.pickerView.reloadAllComponents()
                }
            case .failure(let error):
                print(error)
                }
        }
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch component {
            case 0: return x[row]
            case 1: return y[row]
            default: return "None"
        }
    }
    
 
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        switch component {
            case 0: return x.count
            case 1: return y.count
            default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            countryLabel.text = x[row]
            self.country = x[row]
             pickerView.reloadComponent(0)
            print(self.country)
             runGetRequest2()
             pickerView.reloadComponent(0)
         
        
        }
        if component == 1 {
            stateLabel.text = y[row]
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    @IBAction func registerUser(_ sender: Any) {
        let abc = nickName.text!
         nickName.text = abc.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let def = password.text!
        password.text = def.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let ghi = city.text!
        city.text = ghi.trimmingCharacters(in: .whitespacesAndNewlines)
      
        checkFields()
    }
    
    func checkFields(){
      emptyCheck()
      nickNameTest()
      passwordTest()
      yearTest()
      latlongTest()
    
        let parameters: Parameters = [
            "nickname": "\(nickName.text ?? "nil")",
            "password": "\(password.text ?? "nil")",
            "country": "\(countryLabel.text ?? "nil")",
            "state": "\(stateLabel.text ?? "nil")",
            "city": "\(city.text ?? "nil")",
            "year": Int(yearX.text!) ?? 0 ,
            "longitude": Double(longitude.text!) ?? 0,
            "latitude": Double(latitude.text!) ?? 0
        ]
        print(parameters)
        
        Alamofire.request("https://bismarck.sdsu.edu/hometown/adduser", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseString { response in
                switch response.result { case .success:
                    if let utf8Text = response.result.value {
                        let alert = UIAlertController(title:"Done",message:"Registration Sucess", preferredStyle : .alert)
                        let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                        alert.addAction(closeAction)
                        self.present(alert,animated: true,completion: nil)
                    }
                case .failure(let error):
                    let alert = UIAlertController(title:"Try Again",message:"Registration Failed", preferredStyle : .alert)
                    let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                    alert.addAction(closeAction)
                    self.present(alert,animated: true,completion: nil)
                   
                    
                    print(error)
                    
                }
        }
    }
    
    func emptyCheck(){
        
        
        if nickName.text == ""{
        let alert = UIAlertController(title:"Please enter Nickname",message:"Nickname empty", preferredStyle : .alert)
        let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alert.addAction(closeAction)
        self.present(alert,animated: true,completion: nil)
        }
        
        if password.text == ""{
            let alert = UIAlertController(title:"Please enter Password",message:"Password empty", preferredStyle : .alert)
            let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            alert.addAction(closeAction)
            self.present(alert,animated: true,completion: nil)
        }
        
        if countryLabel.text == ""{
            let alert = UIAlertController(title:"Please select Country",message:"Country empty", preferredStyle : .alert)
            let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            alert.addAction(closeAction)
            self.present(alert,animated: true,completion: nil)
        }
        
        if stateLabel.text == ""{
            let alert = UIAlertController(title:"Please select State",message:"State empty", preferredStyle : .alert)
            let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            alert.addAction(closeAction)
            self.present(alert,animated: true,completion: nil)
        }
        
        
        
        if city.text == ""{
            let alert = UIAlertController(title:"Please enter City",message:"City empty", preferredStyle : .alert)
            let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            alert.addAction(closeAction)
            self.present(alert,animated: true,completion: nil)
        }
        
        if yearX.text == ""{
            let alert = UIAlertController(title:"Please enter year",message:"Year empty", preferredStyle : .alert)
            let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            alert.addAction(closeAction)
            self.present(alert,animated: true,completion: nil)
        }
        
    }
    
    func nickNameTest(){

        Alamofire.request("https://bismarck.sdsu.edu/hometown/nicknameexists?name=\(nickName.text as! String)") .validate()
        .responseJSON { response in switch response.result
        { case .success:
            if let JSON = response.result.value {
                let jsonObject: Int = JSON as! Int
                    if (jsonObject == 1){
                        let alert = UIAlertController(title:"Oops",message:"Nickname exists", preferredStyle : .alert)
                        let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                        alert.addAction(closeAction)
                        self.present(alert,animated: true,completion: nil)
                           self.nickName.text = ""
                    }
                }
        case .failure(let error):
            
            
                print(error) }
        }
    }
    
    func passwordTest(){
        let abc = password.text!
       let trimmed = abc.trimmingCharacters(in: .whitespacesAndNewlines)
        if (trimmed.count < 3)
        {
            let alert = UIAlertController(title:"Oops",message:"Password must be greater than 3", preferredStyle : .alert)
            let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            alert.addAction(closeAction)
            self.present(alert,animated: true,completion: nil)
              self.password.text = ""
        }
    
        
        
    }
    
    func yearTest(){
        
        if let yearTest = Int(yearX.text!) {
            if Int(yearX.text!)! < 1970 || Int(yearX.text!)! > 2017 {
                let alert = UIAlertController(title:"Oops",message:"Years range from 1970-2017", preferredStyle : .alert)
                let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                alert.addAction(closeAction)
                self.present(alert,animated: true,completion: nil)
                self.yearX.text = ""
            }}
        else{
            print("null year handled")
         
        }
    }
    
    func latlongTest(){
       
        if let latitudeTest = Double(latitude.text!){
        if (Double(latitude.text!)! > 90.0 || Double(latitude.text!)! < -90.0)
        {
            let alert = UIAlertController(title:"Oops",message:"Latitude must be in the range of -90 to 90", preferredStyle : .alert)
            let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            alert.addAction(closeAction)
            self.present(alert,animated: true,completion: nil)
        }
            
        }
        
        else{
            print("latitude handled")
        }
        
         if let longitudeTest = Double(longitude.text!){
        if (Double(longitude.text!)! > 180.0 || Double(longitude.text!)! < -180.0)
        {
            let alert = UIAlertController(title:"Oops",message:"Longitude must be in the range of -180 to 180", preferredStyle : .alert)
            let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            alert.addAction(closeAction)
            self.present(alert,animated: true,completion: nil)
        }
        }
         else{
          print("longitude handled")
        }
    }
    
    var activeTextField :UITextField!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            nickName.resignFirstResponder()
            password.resignFirstResponder()
            city.resignFirstResponder()
            yearX.resignFirstResponder()
            latitude.resignFirstResponder()
            longitude.resignFirstResponder()
            return(true)
        }
    
    @objc func keyboardDidShow(notification: Notification){
        let info:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = self.view.frame.size.height - keyboardSize.height
        let editingTextFieldY :CGFloat! = self.activeTextField?.frame.origin.y
        
        if editingTextFieldY > keyboardY - 60 {
            UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.view.frame = CGRect(x: 0,
                        y: self.view.frame.origin.y - (editingTextFieldY! - (keyboardY - 60)),width: self.view.bounds.width,height:self.view.bounds.height)}, completion: nil)
        }
    }
    
    @objc func keyboardWillHide(notification: Notification){
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn,animations:{
            self.view.frame = CGRect(x:0,y:0,width:self.view.bounds.width,height:self.view.bounds.height)},completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func doneClicked(){
        view.endEditing(true)
    }
    
    @objc func toggleMinus(){
        
        if var text1 = longitude.text , text1.isEmpty == false{
            if text1.hasPrefix("-") {
                text1 = text1.replacingOccurrences(of: "-", with: "")
            }
            else
            {
                text1 = "-\(text1)"
            }
            longitude.text = text1
            
        }
    }
    
    @objc func toggleMinus2(){
        
        if var text1 = latitude.text , text1.isEmpty == false{
            if text1.hasPrefix("-") {
                text1 = text1.replacingOccurrences(of: "-", with: "")
            }
            else
            {
                text1 = "-\(text1)"
            }
            latitude.text = text1
            
        }
    }
    
    
}


