

import UIKit
import Firebase

class BooksCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var bookImage: UIImageView!
    
    @IBOutlet var bookName: UILabel!
    
    @IBOutlet var authorName: UILabel!
    
    static let identifier = "BooksCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "BooksCollectionViewCell", bundle: nil)
        
    }

    
    func bind(_ book:getBook){ // bu fonksiyon yatay tabloda değerleri çekmemi sağlıyor.
        bookName.text = book.name
        bookImage.sd_setImage(with: URL(string: book.image)!)
        authorName.text = book.author
    }

}
