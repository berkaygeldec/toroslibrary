

import UIKit
import SDWebImage

class SorumluKitaplarCell: UITableViewCell {
    
    @IBOutlet var bookImageView: UIImageView!
    
    @IBOutlet var bookNameLabel: UILabel!
    
    @IBOutlet var authorLabel: UILabel!
    
    @IBOutlet var bookDescLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func bind(_ book : Book) { // kitapları Sorumlu kitaplarda çekip buraya gönderiyorum burdada değerlerine göre elemanları gösteriyorum.
        bookImageView.sd_setImage(with: URL(string: book.image))
        bookNameLabel.text = book.name
        authorLabel.text = book.author
        bookDescLabel.text = book.description
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
