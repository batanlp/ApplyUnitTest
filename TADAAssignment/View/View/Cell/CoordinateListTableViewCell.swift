//
//  CoordinateListTableViewCell.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 14/10/2021.
//

import UIKit

class CoordinateListTableViewCell: UITableViewCell {

    @IBOutlet weak var lbCoordinate: UILabel!
    @IBOutlet weak var lbDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(info: CoordinateTADA) {
        lbCoordinate.text = "\(info.latitude), \(info.longitude)"
        lbDesc.text = info.desc
    }
    
}
