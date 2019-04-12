//
//  ProfilController.swift
//  TugasBesarRS
//
//  Created by Abi Muliawan Sukarjo on 23/11/18.
//  Copyright © 2018 Tugas Besar Kelompok 1. All rights reserved.
//

import UIKit

class ProfilController: UIViewController {

    @IBOutlet weak var labelNama: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelAlamat: UILabel!
    @IBOutlet weak var labelTanggalLahir: UILabel!
    
    var tampilNama: String!
    var tampilEmail: String!
    var tampilAlamat: String!
    var tampilTanggalLahir: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelNama.text = tampilNama
        labelEmail.text = tampilEmail
        labelAlamat.text = tampilAlamat
        labelTanggalLahir.text = tampilTanggalLahir
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit" {
            if let destination = segue.destination as? EditProfileController {
                destination.putEmail = tampilEmail
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
