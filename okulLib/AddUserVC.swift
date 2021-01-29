

import UIKit
import Firebase

class AddUserVC: UIViewController {
    
    @IBOutlet var userNameLabel: UITextField!
    @IBOutlet var studentIDLabel: UITextField!
    @IBOutlet var tcLabel: UITextField!
    @IBOutlet var phoneNumberLabel: UITextField!
    @IBOutlet var passwordLabel: UITextField!
    @IBOutlet var closeButton: UIImageView!
    var observer:Observer?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        closeButton.isUserInteractionEnabled = true // kullanıcının üzerine basmasını sağlıyor(isUserInteractionEnabled)
        closeButton.addTapGesture { // Kapatma butonunun fonksiyonu  addtapgesture üzerine basınca işlem yapmasını sağlıyor
            self.dismiss(animated: true){
                self.observer?.observe()
            }
        }
    }
    
    
   
    @IBAction func addAction(_ sender: Any) { // Kullanıcıyı ekleme butonu
        // Kontroller yapılıyor duruma göre alert ekranı çıkıyor veya kullanıcı ekleniyor
        if userNameLabel.text == "" || studentIDLabel.text == "" || tcLabel.text == "" || phoneNumberLabel.text == "" || passwordLabel.text == "" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "alert") as! AlertView
            vc.labelText = "Hiçbir alan boş bırakılmamalıdır."
            self.present(vc, animated: true, completion: nil)
        }else{
            
            let firestoreDb = Firestore.firestore()
            
            var ref : DocumentReference? = nil
            
            let post = ["ad_soyad" : userNameLabel.text , "kullanici_adi" : studentIDLabel.text , "sifre" : passwordLabel.text , "tc" : tcLabel.text , "tel" : phoneNumberLabel.text , "status" : "0" ] as [String:Any]
            
            ref = firestoreDb.collection("users").addDocument(data: post, completion: { (error) in
                if error == nil{
                    self.dismiss(animated: true){
                        self.observer?.observe2()
                    }
                }else{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "alert") as! AlertView
                    vc.labelText = "Kullanıcı Eklenemedi"
                    self.present(vc, animated: true, completion: nil)
                }
            })
            
        }
        
    }
    
}
