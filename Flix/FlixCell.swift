//
//  FlixCell.swift
//  Flix
//
//  Created by Harshad Barapatre on 2/6/22.
//

import UIKit

class FlixCell: UITableViewCell {
    
    @IBOutlet weak var flixLabel: UILabel!
    @IBOutlet weak var flixImage: UIImageView!
    @IBOutlet weak var flixSynopsis: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
