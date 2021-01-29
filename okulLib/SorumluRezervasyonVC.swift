
import UIKit
import Firebase

class SorumluRezervasyonVC: UIViewController , updateBook {

    
    func updateBook() {
        print("update book")
        fetchData() // Teslim al butounundan sonra en altta oluşturduğum protocal burdaki işlemleri yapacak. Yani kitapları çekecek.
    }
    

    @IBOutlet var tableView: UITableView!
    @IBOutlet var quitBtn: UIImageView!
    
    var bookArray = [getBook]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "SorumluRezervasyon", bundle: nil), forCellReuseIdentifier: "sorumlurez")
        tableView.delegate = self
        tableView.dataSource = self
        
        
        quitBtn.addTapGesture { // Çıkış düğmesi fonksiyonu
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "giris") as! ViewController
            UserDefaults.standard.setValue("", forKey: "status")
            UserDefaults.standard.setValue("", forKey: "username")
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    
    func fetchData() { // Rezervasyon yapılmış kitapları çekiyorum
        let firestoredb = Firestore.firestore()
        firestoredb.collection("books").whereField("bookstatus", isEqualTo: 1).getDocuments { (data, err) in
            if err != nil  && data != nil{
                print("hata")
            }else{
                self.bookArray.removeAll()
                for document in data!.documents{
                    self.bookArray.append(getBook(name: document.get("bookname") as! String, author: document.get("author" ) as! String, description: document.get("bookdesc") as! String, status: document.get("bookstatus") as! Int, image: document.get("imageurl") as! String, date: document.get("date") as! String, reservedUser: document.get("reserveduser") as! String , type: document.get("type") as! String , id: document.documentID as! String))
                }
                self.tableView.reloadData()
            }
        }
    }
    



}


extension SorumluRezervasyonVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "sorumlurez", for: indexPath) as! SorumluRezervasyon
        cell.bind(bookArray[indexPath.row])
        cell.parent = self
        cell.updateBook = self
        return cell
    }
    
    
}

protocol updateBook { // burda yazdığım protocol kitabı teslim aldıktan sonra sayfayı yenilememi sağlıyor bunu yukarda kullanıyorum.
    func updateBook()
}
