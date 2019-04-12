//
//  EditProfileController.swift
//  TugasBesarRS
//
//  Created by Abi Muliawan Sukarjo on 26/11/18.
//  Copyright © 2018 Tugas Besar Kelompok 1. All rights reserved.
//

import UIKit
import Alamofire

class EditProfileController: UIViewController {

    @IBOutlet weak var txtNama: UITextField!
    @IBOutlet weak var txtTanggal: UITextField!
    @IBOutlet weak var txtAlamat: UITextField!
    let datePicker = UIDatePicker()
    var putEmail: String!
    
    let URL_UPDATE = "http://abimuliawan.site/EditProfile.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        createDatePicker()
    }
    
    @IBAction func btnEdit(_ sender: Any) {
        
        let requestURL = NSURL(string: URL_UPDATE)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        
        //getting values from text fields
        let emailInput = putEmail
        let namaInput = txtNama.text
        let alamatInput = txtAlamat.text
        let tanggalInput = txtTanggal.text
        
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "email="+emailInput!+"&nama="+namaInput!+"&alamat="+alamatInput!+"&tanggal_lahir="+tanggalInput!;
        
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
                    
                    let alertController = UIAlertController(title: "Info Update", message:
                       msg , preferredStyle: UIAlertController.Style.alert)
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
