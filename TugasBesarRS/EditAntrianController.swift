//
//  EditAntrianController.swift
//  TugasBesarRS
//
//  Created by Abi Muliawan Sukarjo on 28/11/18.
//  Copyright © 2018 Tugas Besar Kelompok 1. All rights reserved.
//

import UIKit

class EditAntrianController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var dokter = ["Dr. Agus Gunawan", "Dr. Eka Julianti", "Dr. Vera Nevada"]
    var picker = UIPickerView()
    var email: String!
    
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var txtDokter: UITextField!
    @IBOutlet weak var txtTanggal: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        self.hideKeyboardWhenTappedAround()

    }
    
    @IBAction func btnEdit(_ sender: Any) {
        
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
