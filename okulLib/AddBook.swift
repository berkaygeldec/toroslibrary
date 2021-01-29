

import UIKit
import Firebase

class AddBook: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIPickerViewDelegate , UIPickerViewDataSource{
    
    
    var pickerView1 =  UIPickerView()
    var array = ["Edebiyat" , "Ekonomi" , "Yazılım" , "Dünya Klasikleri"] // picker değerleri
    @IBOutlet var addBookImageView: UIImageView!

    @IBOutlet var bookNameTextField: UITextField!
    
    @IBOutlet var authorNameTextField: UITextField!
    
    @IBOutlet var bookDescTextField: UITextField!
    
    @IBOutlet var bookTypeTextField: UITextField!
    
    
    var status = 0
    var selectedRow = 0
    @IBOutlet var closePage: UIImageView!
    var observer : Observer2?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        pickerView1.delegate = self // Kitabın türü için çoktan seçmeli bir textfield oluşturdum.
        pickerView1.dataSource = self
        
        bookTypeTextField.inputView = pickerView1
        
        closePage.addTapGesture {
            self.dismiss(animated: true){
                self.observer?.getData()
                
                
            }
        }

        addBookImageView.addTapGesture {  // Resme tıklayınca olacak aksiyonların fonksiyonu
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { // 1 tane picker olacak
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { //Picker değerlerinin array i kadar eleman dönecek
        return array.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row] // array ' in elemanlarını tek tek alacak ve gösterecek
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            bookTypeTextField.text = array[row]
            bookTypeTextField.resignFirstResponder()
        selectedRow = row;
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) { // Fotoğraf galerisini açmayyı sağlayan fonksiyom
        addBookImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil) // kapatmamı sağlıyor seçtikten sonra
        status = 1
    }
    
  
    
    @IBAction func addAction(_ sender: Any) { // Kitabı ekleme butonunun fonkstionu
        
        if bookNameTextField.text == "" || bookDescTextField.text == "" || authorNameTextField.text == "" || addBookImageView.image == UIImage(named: "add") || addBookImageView.image == UIImage(named: "") || status == 0 || bookTypeTextField.text == ""{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "alert") as! AlertView
            vc.imageName = "error"
            vc.labelText = "Kitap Eklenemedi - Lütfen Eksik Alan bırakmayınız"
            vc.buttonText = "Tekrar Dene"
            self.present(vc, animated: true, completion: nil)
        }else{
            let storage = Storage.storage()
            let storageRef = storage.reference()
            
            let imageFolder = storageRef.child("kitaplar")
            
            if let data = addBookImageView.image?.jpegData(compressionQuality: 0.5) {
                let uuid = UUID().uuidString
                let imageRef = imageFolder.child("\(uuid).jpg")
                imageRef.putData(data, metadata: nil) { (metadata, error) in
                    if error != nil {
                        print("error1")
                    }else{
                        imageRef.downloadURL { (url, error) in
                            if error != nil {
                                print("error2")
                            }else{
                                let imageUrl = url?.absoluteString
                                print(imageUrl)
                                
                                
                                // Database
                                
                                
                                let firestoreDatabase = Firestore.firestore()
                                let firestoreRef : DocumentReference?
                                
                                let data = ["imageurl" : imageUrl! , "bookname" : self.bookNameTextField.text! , "author" : self.authorNameTextField.text! , "bookstatus" : 0 , "bookdesc" : self.bookDescTextField.text! , "date" : "" , "reserveduser" : "" , "type" : self.bookTypeTextField.text!] as [String : Any]
                                
                                firestoreRef = firestoreDatabase.collection("books").addDocument(data: data, completion: { (error) in
                                    if error == nil {
                                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "alert") as! AlertView
                                        vc.imageName = "check"
                                        vc.labelText = "Kitap başarılı bir şekilde eklendi"
                                        vc.buttonText = "Devam Et"
                                        self.present(vc, animated: true, completion: nil)
                                    }
                                })
                            }
                        }
                    }
                }
            }
        }
        
        
    }
    

}
