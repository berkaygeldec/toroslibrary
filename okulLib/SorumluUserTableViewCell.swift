

import UIKit

class SorumluUserTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var schollNumberLabel: UILabel!
    @IBOutlet var telLabel: UILabel!
    @IBOutlet var tcLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(_ student:Student)  { // Tabloya kullanıcıların bilgilerini çekiyorum
        nameLabel.text = student.name
        schollNumberLabel.text = student.schoolNumber
        telLabel.text = student.phoneNumber
        tcLabel.text  = student.idNumber
        
    }// modeli ayrı bir klasçrde açayım mı ?
    
}
