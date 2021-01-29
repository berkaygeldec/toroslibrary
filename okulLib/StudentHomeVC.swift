

import UIKit
import Firebase

var sectionArray = [String]()

class StudentHomeVC: UIViewController{
    

    @IBOutlet var tableView: UITableView!
    var categories = [Category]() // Category tipinde bir boş array oluşturdum
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        tableView.register(UINib(nibName: "StudentBookCell", bundle: nil), forCellReuseIdentifier: "booktableviewcell") // Tableview ' a cell ekledim.
        tableView.delegate = self // Tableview izinlerini verdim.
        tableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        categories.removeAll() // arrayi boşaltıyorum
        fetchData() // data çekme fonksiyonumu çağırıyorum
        tableView.reloadData() // tabloyu yeniliyorum
    }
    
    
    func fetchData(){ // Datayı çekiyorum
        let firestoredb = Firestore.firestore()
        firestoredb.collection("books").whereField("bookstatus", isEqualTo: 0).getDocuments { (data, err) in
            if err != nil  && data != nil{
                print("hata")
            }else{
                
                for document in data!.documents{
                    let book = getBook(name: document.get("bookname") as! String, author: document.get("author" ) as! String, description: document.get("bookdesc") as! String, status: document.get("bookstatus") as! Int, image: document.get("imageurl") as! String, date: document.get("date") as! String, reservedUser: document.get("reserveduser") as! String , type: document.get("type") as! String , id: document.documentID)
                    self.addOrUpdate(type: document.get("type") as? String ?? "Diğer" , book)
                }
                print("Resetlendi")
                self.tableView.reloadData()
            }
        }
    }
    
    
    func addOrUpdate(type:String?,_ book:getBook)  { // Burda kitapların türlerine bakıp eğer daha önce olmayan bir tür ise ona özel bir cell oluşturuyorum.
        let category = Category(type: type, books: [book])
        let i = categories.firstIndex(of: category)
        if i != nil {
            categories[i!].books?.append(book)
        }else{
            categories.append(category)
        }
    }
    
    

}


extension StudentHomeVC : UITableViewDelegate , UITableViewDataSource { // Tablonun kaç satır olacağı
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // Tablonun içeriğini ayarlıyorum
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "booktableviewcell", for: indexPath) as! StudentBookCell // tabloyu tanımladım
        cell.titleLabel.text = categories[indexPath.row].type ?? "Diğer" // başlıkları ayarladım
        cell.books = categories[indexPath.row].books ?? [] // kitapları tabloya yolladım
        cell.parent = self
        cell.collectionView.reloadData() // collection view yani yana doğru olan tabloyu yeniledim
        return cell // tabloyu döndürdüm
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { // tablonun yüksekliğini belirttim
        return 300
    }
    
    
}


struct Category:Equatable { // Bu Modeli title ' ları kontrol etmek için oluşturdum
    
    var type:String?
    var books:[getBook]?
    
    static func == (lhs: Category, rhs: Category) -> Bool { // İkisi eşitmi kontrol ettim
        return lhs.type == rhs.type
    }
}

protocol updateData {
    func updateData()
}
