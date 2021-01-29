

import UIKit
import SDWebImage // firebase den resimleri link olarak alıyorum bu kütüphane onları resimleştiriyor.

class StudentUserTableViewCell: UITableViewCell {

    @IBOutlet var bookImage: UIImageView!
    @IBOutlet var bookNameLabel: UILabel!
    @IBOutlet var yazarLabel: UILabel!
    @IBOutlet var teslimTarihiLabel: UILabel!

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(_ book : getBook){ // Tablonun image , kitap adı , yazarı , ve alındığı tarihi alıyorum
        bookImage.sd_setImage(with: URL(string: book.image))
        bookNameLabel.text = book.name
        yazarLabel.text = book.author
        teslimTarihiLabel.text = book.date
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
