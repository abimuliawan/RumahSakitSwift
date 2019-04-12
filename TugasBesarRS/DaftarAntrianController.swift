//
//  DaftarAntrianController.swift
//  TugasBesarRS
//
//  Created by Abi Muliawan Sukarjo on 13/11/18.
//  Copyright © 2018 Tugas Besar Kelompok 1. All rights reserved.
//

import UIKit

class DaftarAntrianController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var dokter = ["Dr. Agus Gunawan", "Dr. Eka Julianti", "Dr. Vera Nevada"]
    var picker = UIPickerView()
    var email: String!
    
    @IBOutlet weak var txtDokter: UITextField!
    @IBOutlet weak var txtTanggal: UITextField!
    
    
    //URL to our web service
    let URL_USER = "http://abimuliawan.site/InsertAntrian.php"
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        txtDokter.inputView = picker
        self.hideKeyboardWhenTappedAround()
        createDatePicker()
        
    }
    @IBAction func btnDaftar(_ sender: Any) {
        //created NSURL
        let requestURL = NSURL(string: URL_USER)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        
        //getting values from text fields
        let dokterInput = txtDokter.text
        let tanggalInput = txtTanggal.text
        let emailInput = self.email
        
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "email="+emailInput!+"&nama_dokter="+dokterInput!+"&tanggal="+tanggalInput!;
        
        //adding the parameters to request body
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil{
                print("error is \( error )")
                return;
            }
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                //parsing the json
                if let parseJSON = myJSON {
                    
                    //creating a string
                    var msg : String!
                    
                    //getting the json response
                    msg = parseJSON["message"] as! String?
                    
                    //printing the response
                    print(msg)
                    
                    let alertController = UIAlertController(title: "Info Pendaftaran", message:
                        msg, preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            } catch {
                print(error)
            }
            
        }
        //executing the task
        task.resume()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dokter.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dokter[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtDokter.text = dokter[row]
        self.view.endEditing(false)
    }
    
    func createDatePicker(){
        datePicker.datePickerMode = .date
        txtTanggal.inputView = datePicker
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClickTanggal))
        toolBar.setItems([doneButton], animated: true)
        
        txtTanggal.inputAccessoryView = toolBar
    }
    
    @objc func doneClickTanggal(){
        let dateFormate = DateFormatter()
        dateFormate.dateStyle = .medium
        dateFormate.timeStyle = .none
        txtTanggal.text = dateFormate.string(from: datePicker.date)
        self.view.endEditing(true)
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

