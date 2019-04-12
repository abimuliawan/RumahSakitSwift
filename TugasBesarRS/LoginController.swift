//
//  LoginController.swift
//  TugasBesarRS
//
//  Created by Abi Muliawan Sukarjo on 13/11/18.
//  Copyright © 2018 Tugas Besar Kelompok 1. All rights reserved.
//

import UIKit
import Alamofire

class LoginController: UIViewController {
    
   
    @IBOutlet weak var btnRegis: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLog: UIButton!
    
    var namaInput: String!
    var emailInput: String!
    var alamatInput: String!
    var tanggalLahirInput: String!
    
    var inputSague: String!

    let URL_USER_LOGIN = "http://abimuliawan.site/Login.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let attributedString = NSAttributedString(string: "Anda Belum Punya Akun?", attributes: [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.underlineStyle:1])
        
        btnRegis.setAttributedTitle(attributedString, for: .normal)
        self.hideKeyboardWhenTappedAround()
        
        inputSague = txtEmail.text
        
    }
    
    
    @IBAction func btnLogin(_ sender: UIButton) {
        
        //getting the username and password
        let parameters: Parameters=[
            "email":txtEmail.text!,
            "password":txtPassword.text!
        ]
        sender.pulse()
        
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
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
                        let email = jsonData.value(forKey: "email") as! String
                        let nama =  jsonData.value(forKey: "nama") as! String
                        let alamat = jsonData.value(forKey: "alamat") as! String
                        let tanggal_lahir = jsonData.value(forKey: "tanggal_lahir") as! String
                        
                        self.namaInput = nama
                        self.alamatInput = alamat
                        self.emailInput = email
                        self.tanggalLahirInput = tanggal_lahir
                        
                        print(self.namaInput)
                        
                        self.performSegue(withIdentifier: "login", sender: self)
                      
                    }else{
                        //error message in case of invalid credential
                        let alertController = UIAlertController(title: "Tidak Dapat Login", message:
                            "Cek Kembali Email dan Password", preferredStyle: UIAlertController.Style.alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                    
                        sender.shake()
                       
                    }
                }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login" {
            if let destination = segue.destination as? MenuUtamaController {
                destination.showNama = namaInput
                destination.showEmail = emailInput
                destination.showAlamat = alamatInput
                destination.showTanggalLahir = tanggalLahirInput
            }
        }
    }
    

    

    
}




