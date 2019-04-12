//
//  MenuUtamaController.swift
//  TugasBesarRS
//
//  Created by Abi Muliawan Sukarjo on 12/11/18.
//  Copyright © 2018 Tugas Besar Kelompok 1. All rights reserved.
//

import UIKit

class MenuUtamaController: UIViewController {
    
    @IBOutlet weak var labelNama: UILabel!
    var showNama: String!
    var showAlamat: String!
    var showTanggalLahir: String!
    var showEmail: String!
    
    
    @IBAction func btnDaftarAntrian(_ sender: UIButton) {
        sender.pulse()
    }
    
    @IBAction func btnAntrianAnda(_ sender: UIButton) {
        sender.pulse()
    }
    
    @IBAction func btnGPS(_ sender: UIButton) {
        sender.pulse()
    }
    
    @IBAction func btnApotek(_ sender: UIButton) {
        sender.pulse()
    }
    
    @IBAction func btnDaftarDokter(_ sender: UIButton) {
        sender.pulse()
    }
    @IBAction func btnQR(_ sender: UIButton) {
        sender.pulse()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        labelNama.text = "Hello,"+showNama
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profile" {
            if let destination = segue.destination as? ProfilController {
                destination.tampilNama = showNama
                destination.tampilEmail = showEmail
                destination.tampilAlamat = showAlamat
                destination.tampilTanggalLahir = showTanggalLahir
                
            }
        } else if segue.identifier == "daftarAntrian"{
            if let destination = segue.destination as? DaftarAntrianController {
                destination.email = showEmail
                
            }
        }
        else if segue.identifier == "antrianAnda"{
            if let destination = segue.destination as? AntrianAndaController {
                destination.emailInput = showEmail
                
            }
        }
    }
    
    

}
