//
//  ApotekController.swift
//  TugasBesarRS
//
//  Created by Abi Muliawan Sukarjo on 13/11/18.
//  Copyright © 2018 Tugas Besar Kelompok 1. All rights reserved.
//

import UIKit

class ApotekController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tabelApotek: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var obatArray = [Obat]()
    var currentObat = [Obat]()
    
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpObat()
        self.hideKeyboardWhenTappedAround()
        tabelApotek.delegate = self
        tabelApotek.dataSource = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        
    }
    

    
    private func setUpObat(){
        obatArray.append(Obat(nama: "Tongli", harga: 28000, image: "Obat 1"))
        obatArray.append(Obat(nama: "Dumin", harga: 10000, image: "Obat 2"))
        obatArray.append(Obat(nama: "Albothyl", harga: 35000, image: "Obat 3"))
        obatArray.append(Obat(nama: "OBH Combi", harga: 11000, image: "Obat 4"))
        obatArray.append(Obat(nama: "Panadol CF", harga: 9000, image: "Obat 5"))
        obatArray.append(Obat(nama: "Counterpain", harga: 38000, image: "Obat 6"))
        obatArray.append(Obat(nama: "Mixagrip", harga: 2000, image: "Obat 7"))
        obatArray.append(Obat(nama: "Diapet", harga: 5000, image: "Obat 8"))
        obatArray.append(Obat(nama: "Termorex", harga: 18000, image: "Obat 9"))
        obatArray.append(Obat(nama: "Emergen-C", harga: 34000, image: "Obat 10"))
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching{
            return currentObat.count
        }else{
             return obatArray.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! TableViewCellApotek
        
        if searching{
            cell.imageCell.image =  UIImage(named: currentObat[indexPath.row].image)
            cell.namaLabel.text = currentObat[indexPath.row].nama
            cell.hargaLabel.text = "Rp. " + String(currentObat[indexPath.row].harga)
            
        }else{
            cell.imageCell.image =  UIImage(named: obatArray[indexPath.row].image)
            cell.namaLabel.text = obatArray[indexPath.row].nama
            cell.hargaLabel.text = "Rp. " + String(obatArray[indexPath.row].harga)
        }
        
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         self.performSegue(withIdentifier: "transaksi", sender: self)
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentObat = obatArray.filter({$0.nama.prefix(searchText.count) == searchText})
        searching = true
        tabelApotek.reloadData()
    }
    
    
}


