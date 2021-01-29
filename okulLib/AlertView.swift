

import UIKit

class AlertView: UIViewController { // Alert ekranı

    var labelText = ""
    var buttonText = ""
    var imageName = ""
    @IBOutlet var layer: UIView!
    
    @IBOutlet var alertImage: UIImageView!
    @IBOutlet var infoLabel: UILabel!
    var update : updateBook?
    
    @IBOutlet var againbUTTON: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        layer.layer.cornerRadius = 15 // burda dış alanın radiusunu verdim
        againbUTTON.layer.cornerRadius = 10 // buton radiusu
    }
    
    
    override func viewWillAppear(_ animated: Bool) { // uygulama açılırken ilk burası çalışıyor.
        infoLabel.text = labelText
        
        if buttonText == ""{
            
        }else{
            againbUTTON.setTitle("Devam Et", for: .normal)
        }
        
        if imageName == "" {
            
        }else{
            alertImage.image = UIImage(named: imageName)
        }
        
        update?.updateBook()
    }
    

    @IBAction func tekrarDeneAction(_ sender: Any) { // Butona tıklayınca olacak aksiyonlar bu fonksiyon içerisinde
        update?.updateBook()
        self.dismiss(animated: true, completion: nil)
    }
    

}
