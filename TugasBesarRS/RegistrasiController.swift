//
//  RegistrasiController.swift
//  TugasBesarRS
//
//  Created by Abi Muliawan Sukarjo on 12/11/18.
//  Copyright © 2018 Tugas Besar Kelompok 1. All rights reserved.
//

import UIKit

class RegistrasiController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var nama: UITextField!
    @IBOutlet weak var tanggal_lahir: UITextField!
    @IBOutlet weak var alamat: UITextField!
    let datePicker = UIDatePicker()
    
    //URL to our web service
    let URL_USER = "http://abimuliawan.site/Registrasi.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        createDatePicker()
    }
    
    @IBAction func register(_ sender: Any) {
        //created NSURL
        let requestURL = NSURL(string: URL_USER)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        
        //getting values from text fields
        let emailInput = email.text
        let namaInput = nama.text
        let passwordInput = password.text
        let alamatInput = alamat.text
        let tanggalInput = tanggal_lahir.text
        
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "email="+emailInput!+"&password="+passwordInput!+"&nama="+namaInput!+"&alamat="+alamatInput!+"&tanggal_lahir="+tanggalInput!;
        
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
                    
                    let alertController = UIAlertController(title: "Registrasi Berhasil", message:
                        "Silahkan Login Dengan Menggunkan Email dan Password yang Sudah Terdaftar", preferredStyle: UIAlertController.Style.alert)
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
    
    
    func createDatePicker(){
        datePicker.datePickerMode = .date
        tanggal_lahir.inputView = datePicker
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClickTanggal))
        toolBar.setItems([doneButton], animated: true)
        
        tanggal_lahir.inputAccessoryView = toolBar
    }
    
    @objc func doneClickTanggal(){
        let dateFormate = DateFormatter()
        dateFormate.dateStyle = .medium
        dateFormate.timeStyle = .none
        tanggal_lahir.text = dateFormate.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    


}
