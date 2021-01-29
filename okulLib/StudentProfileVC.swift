

import UIKit
import Firebase

class StudentProfileVC: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var tcLabel: UILabel!
    @IBOutlet var studentNoLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var quitBtn: UIImageView!
    var booksArray = [getBook]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "StudentUserTableViewCell", bundle: nil), forCellReuseIdentifier: "studentprofilecell")
        tableView.delegate = self
        tableView.dataSource = self
        
        quitBtn.addTapGesture {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "giris") as! ViewController
            UserDefaults.standard.setValue("", forKey: "status")
            UserDefaults.standard.setValue("", forKey: "username")
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        getUser()
    }
    
    
    func getUser(){ // Giriş yapan öğrencinin bilgilerini çekiyorum
        let userName = UserDefaults.standard.string(forKey: "username")
        studentNoLabel.text = "Öğrenci No : " + userName!
        
        let firestoredb = Firestore.firestore()
        firestoredb.collection("users").whereField("kullanici_adi", isEqualTo: userName).getDocuments { (data, error) in
            if error != nil && data != nil {
                
            }else{
                for document in data!.documents{
                    self.nameLabel.text = document.get("ad_soyad") as! String
                    self.tcLabel.text = "TC : " + (document.get("tc")as! String)
                    self.phoneNumberLabel.text = "Tel : " + (document.get("tel")as! String)
                }
            }
        }
    }
    
    func fetchData(){ // Öğrencinin rezervasyon yaptığı kitapları çekiyorum
        let firestoredb = Firestore.firestore()
        firestoredb.collection("books").whereField("reserveduser", isEqualTo: UserDefaults.standard.string(forKey: "username")!).getDocuments { (data, err) in
            if err != nil  && data != nil{
                print("hata")
            }else{
                self.booksArray.removeAll()
                for document in data!.documents{
                    self.booksArray.append(getBook(name: document.get("bookname") as! String, author: document.get("author" ) as! String, description: document.get("bookdesc") as! String, status: document.get("bookstatus") as! Int, image: document.get("imageurl") as! String, date: document.get("date") as! String, reservedUser: document.get("reserveduser") as! String , type: document.get("type") as! String , id: document.documentID))
                }
                print("Resetlendi")
                self.tableView.reloadData()
            }
        }
    }
    

}

extension StudentProfileVC : UITableViewDelegate , UITableViewDataSource { // tablo ayarlarını yapıyorum
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "studentprofilecell", for: indexPath) as! StudentUserTableViewCell
        cell.bind(booksArray[indexPath.row])
        return cell
    }
    
    
}
