//
//  SearchCell.swift
//  okulLib
//
//  Created by Mustafa Çağrı Peker on 22.01.2021.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet var bookImage: UIImageView!
    @IBOutlet var bookNameLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
