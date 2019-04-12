//
//  AntrianAndaController.swift
//  TugasBesarRS
//
//  Created by Abi Muliawan Sukarjo on 13/11/18.
//  Copyright © 2018 Tugas Besar Kelompok 1. All rights reserved.
//

import UIKit
import Alamofire

class AntrianAndaController: UIViewController {

    @IBOutlet weak var labelDokter: UILabel!
    @IBOutlet weak var labelTanggal: UILabel!
    var emailInput: String!
    
    let URL_USER = "http://abimuliawan.site/ShowAntrian.php"
    let URL_DELETE = "http://abimuliawan.site/DeleteAntrian.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let email: String = emailInput
        //getting email
        let parameters: Parameters=[
            "email": email
        ]
        
        Alamofire.request(URL_USER, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    //if there is no error
                    if(!(jsonData.value(forKey: "response") as! Bool)){
                        
                        //getting the user from response
                        let namaDokter =  jsonData.value(forKey: "nama_dokter") as! String
                        let tanggal_lahir = jsonData.value(forKey: "tanggal") as! String
                        
                        self.labelDokter.text = namaDokter
                        self.labelTanggal.text = tanggal_lahir
                        
                    }else{
                        //error message in case of invalid credential
                        let alertController = UIAlertController(title: "Tidak Terdata", message:
                            "Anda Tidak Mempunyai Antrian, Harap Daftar Terlebih Dahulu", preferredStyle: UIAlertController.Style.alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                        
                    }
                }
        }
        
       
    }
    
    
    @IBAction func btnDeleteAntrian(_ sender: Any) {
        //created NSURL
        let requestURL = NSURL(string: URL_DELETE)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        
        //getting values from text fields
        let email: String = emailInput
        //getting email
        let postParameters = "email="+emailInput!;
        
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
                    
                    let alertController = UIAlertController(title: "Info Delete", message:
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
    
    


}
