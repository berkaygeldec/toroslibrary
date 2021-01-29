

import UIKit
import SDWebImage
import Firebase

class RezervasyonPage: UIViewController {

    @IBOutlet var kitapImage: UIImageView!
    @IBOutlet var kitapNameLabel: UILabel!
    @IBOutlet var yazarLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var closeButton: UIImageView!
    
    var user = UserDefaults.standard.string(forKey: "username")
    
    var bookID : String?
    
    var dateString : String?
    
    var book : getBook?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeButton.addTapGesture {
            self.dismiss(animated: true, completion: nil)
        }

        bookID = book?.id
        kitapImage.sd_setImage(with: URL(string: book!.image))
        kitapNameLabel.text = book?.name
        yazarLabel.text = book?.author
        descLabel.text = book?.description
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let formatter = DateFormatter()  // Şuanki tarihi almak için formatter oluşturdum.
        formatter.dateFormat = "d/M/y HH:mm" // Formatterin formatını belirledim
        let now = Date() // Bu günü aldım
        dateString = formatter.string(from: now) // String tipine çevirdim tarihi
    }
    

    @IBAction func rezervasyonClick(_ sender: Any) { // Rezervasyon butonuna tıklayınca olacakların olduğu fonksiyon
        
        let firestoreDB = Firestore.firestore()
        
        let data = ["bookstatus" : 1 , "reserveduser" : user! , "date" : dateString!] as [String : Any] // Firebasede kitabın statusunu , rezervasyon yapan kullanıcı ve alınan tarihi değiştiriyorum.
        
        firestoreDB.collection("books").document(bookID!).setData(data, merge: true) // Burdada kaydediyorum.
        
        
        // İşlem bittikten sonra alert ekranı çıkartıyorum.
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "alert") as! AlertView
        vc.imageName = "check"
        vc.labelText = "Rezervasyon başarılı bir şekilde oluşturuldu"
        vc.buttonText = "Devam Et"
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
}
