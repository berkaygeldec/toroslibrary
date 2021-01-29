

import UIKit
import Firebase
import SDWebImage

struct Book {
    var name : String
    var author : String
    var description : String
    var status : Int
    var image : String
    var date : String
    var reservedUser : String
    var type : String
}

class SorumluKitaplar: UIViewController , Observer2{
    func getData() {
        fetchData()
    }
    

    


    

    @IBOutlet var tableView: UITableView!
    
    var booksArray = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SorumluKitaplarCell", bundle: nil), forCellReuseIdentifier: "sorumlukitap")
        
        
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData() // data çekme fonksioynu çağırıldı.
    }
    
    
    @IBAction func addBookAction(_ sender: Any) { // Kitap ekleme butonu aksiyonu
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "addbook") as! AddBook
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    func fetchData(){ // kitapları çekiyorum
        let firestoredb = Firestore.firestore()
        firestoredb.collection("books").getDocuments { (data, err) in
            if err != nil  && data != nil{
                print("hata")
            }else{
                self.booksArray.removeAll()
                for document in data!.documents{
                    self.booksArray.append(Book(name: document.get("bookname") as! String, author: document.get("author" ) as! String, description: document.get("bookdesc") as! String, status: document.get("bookstatus") as! Int, image: document.get("imageurl") as! String, date: document.get("date") as! String, reservedUser: document.get("reserveduser") as! String , type: document.get("type") as! String))
                }
                print("Resetlendi")
                self.tableView.reloadData()
            }
        }
    }

}

extension SorumluKitaplar : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "sorumlukitap", for: indexPath) as! SorumluKitaplarCell
        cell.bind(booksArray[indexPath.row])
        return cell
    }
    
    
}
protocol Observer2{
    func getData()
}
