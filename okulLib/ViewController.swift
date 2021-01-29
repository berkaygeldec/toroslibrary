

import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController, UITextFieldDelegate {  // UITextFieldDelegate -> textfield üzerinde işlem yapmamı sağlıyor(Placeholder 'ın tipini değiştirmek için gerekli)

    @IBOutlet var titleLabel: UILabel!  // Ui elementlerini tanıtıyorum
    @IBOutlet var kullaniciAdiTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var subtitleLabel: UILabel!
    
    
    let username = UserDefaults.standard.string(forKey: "username") // girilen kullanıcı adını ve statüsünü local hafızada oluşturuyorum.
    let status = UserDefaults.standard.string(forKey: "status")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Özellikler
        // Klavyede geç tuşuna basınca klavye kapanır
        // Herhangi bir yere basınca klavye kapanır
        // Özel bir alert view ekledim
        // k.adı ve şifre boşsa uyarı verir.
        // Şifre yanlışsa uyarı verir.
        // Kullanıcı adı yanlışsa uyarı verir.
        
        
        kullaniciAdiTextField.delegate = self
        passwordTextField.delegate = self
        
        
        titleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.adjustsFontSizeToFitWidth = true
        kullaniciAdiTextField.attributedPlaceholder = NSAttributedString(string: "Kullanıcı Adı", // Placeholder ayarı
                                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Şifre",
                                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    
        let closeKeyboardTapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)) // Burda herhangi biryere tıklayınca klavyenin kapanmasını söylüyorum.
        view.addGestureRecognizer(closeKeyboardTapGesture)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // Klavyedeki  Done butonuna kapatma özelliği ekledim
        textField.resignFirstResponder()
        return true
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)  // Klavyenin kapanması için yazdığım function yukarıda onu kullanıyorum.
    }
    
    
    func getUser(){ // Firebaseden kullanıcıları çekiyorum ve kullanıcı adı  - şifre uyumunu kontrol ediyorum.
        let db = Firestore.firestore()
        
        if kullaniciAdiTextField.text != "" || passwordTextField.text != ""{
            db.collection("users").whereField("kullanici_adi", isEqualTo: kullaniciAdiTextField.text).getDocuments { (data, error) in
                
                if let err = error {
                            print("Error getting documents: \(err)")
                        } else {
                            
                            if data?.documents == nil || data?.documents == [] {
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "alert") as! AlertView
                                vc.labelText = "Böyle bir kullanıcı bulunamadı."
                                self.present(vc, animated: true, completion: nil)
                            }
                            for document in data!.documents {
                                
                                let password = document.get("sifre") as! String
                                let status = document.get("status") as! String
                                
                                if self.passwordTextField.text == password{
                                    if status == "0"{
                                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "studentNav") as! UITabBarController // Eğer uyum varsa yönlendirme yapıyorum
                                        self.present(vc, animated: true, completion: nil)
                                    }else{
                                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "sorumluNav")  as! UITabBarController
                                        self.present(vc, animated: true, completion: nil)
                                    }
                                    UserDefaults.standard.setValue(document.get("status"), forKey: "status") // Eğer uyuşursa username ve statuyu local hafızaya alıyorum.
                                    UserDefaults.standard.setValue(document.get("kullanici_adi"), forKey: "username")
                                    
                                }else{
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "alert") as! AlertView // Eğer uyuşmazsa alert ekranını çıkartıyorum
                                    vc.labelText = "Lütfen şifrenizi kontrol ediniz."
                                    self.present(vc, animated: true, completion: nil)
                                }
                            }
                        }
                
            }
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "alert") as! AlertView
            vc.labelText = "Kullanıcı adı veya Şifre boş bırakılamaz"
            self.present(vc, animated: true, completion: nil)
        }
        
        
    }

    @IBAction func loginAction(_ sender: Any) {
        
        getUser()
    }
    
}

