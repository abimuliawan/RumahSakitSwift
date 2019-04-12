//
//  TableViewCellApotek.swift
//  TugasBesarRS
//
//  Created by Abi Muliawan Sukarjo on 14/11/18.
//  Copyright © 2018 Tugas Besar Kelompok 1. All rights reserved.
//

import UIKit

class TableViewCellApotek: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var namaLabel: UILabel!
    @IBOutlet weak var hargaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
