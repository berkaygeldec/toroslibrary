
import UIKit
import SDWebImage
import Firebase

class SorumluRezervasyon: UITableViewCell {

    @IBOutlet var kitapImage: UIImageView!
    @IBOutlet var kitapNameLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var ogrenciNameLabel: UILabel!
    var id : String?
    var updateBook : updateBook?
    var parent : UIViewController?

        override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(_ book : getBook) { // Kitap bilgilerini tabloya çekiyorum.
        kitapImage.sd_setImage(with: URL(string: book.image))
        kitapNameLabel.text = book.name
        authorLabel.text = book.author
        ogrenciNameLabel.text = book.reservedUser
        id = book.id
    }
    @IBAction func teslimAlAction(_ sender: Any) { // Bu butona tıklayınca teslim alıyorum
        print("a")
        let firestoreDB = Firestore.firestore()
        
        let data = ["bookstatus" : 0 , "reserveduser" : "" , "date" : ""] as [String : Any] // Değerleri boşaltıyorum
        
        firestoreDB.collection("books").document(id!).setData(data, merge: true) // kaydediyorum
        updateBook?.updateBook()
        
        // Alert ekranı çıkartıyorum.
        let vc = parent?.storyboard?.instantiateViewController(withIdentifier: "alert") as! AlertView
        vc.imageName = "check"
        vc.labelText = "Kitap teslim alındı"
        vc.buttonText = "Devam Et"
        parent?.present(vc, animated: true, completion: nil)
        
    }
    
}
